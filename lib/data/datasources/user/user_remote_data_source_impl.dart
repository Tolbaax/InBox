import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/params/auth/user_params.dart';
import '../../models/user_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataSourceImpl(this.auth, this.firestore, this.firebaseStorage);

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<UserModel> getCurrentUser() async {
    var userData =
        await firestore.collection('users').doc(await getCurrentUID()).get();
    UserModel user = UserModel.fromJson(userData.data()!);
    return user;
  }

  @override
  Future<void> setUserState(bool isOnline) async {
    await firestore.collection('users').doc(await getCurrentUID()).update(
      {
        'isOnline': isOnline,
        'lastSeen': DateTime.now().microsecondsSinceEpoch,
      },
    );
  }

  Future<String> _storeFileToFirebase(String path, File file) async {
    if (!file.existsSync()) return '';

    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _deleteFileFromFirebase(String path) async {
    return await firebaseStorage.refFromURL(path).delete();
  }

  Future<UserModel> getUserData(String uID) async {
    final userData = await firestore.collection('users').doc(uID).get();
    return UserModel.fromJson(userData.data()!);
  }

  Future<void> _updateProfilePic(String path) async {
    try {
      final uID = await getCurrentUID();
      final user = await getUserData(uID);

      final batch = firestore.batch();

      if (user.profilePic.isNotEmpty) {
        await _deleteFileFromFirebase(user.profilePic);
      }

      final photoUrl = await uploadNewProfilePic(uID, path);

      // Update profile picture URL in user data
      batch.update(
          firestore.collection('users').doc(uID), {'profilePic': photoUrl});

      // Update profile picture URL in user posts
      final userPostsQuery = await firestore
          .collection('posts')
          .where('uID', isEqualTo: uID)
          .get();

      for (final postDoc in userPostsQuery.docs) {
        batch.update(postDoc.reference, {'profilePic': photoUrl});
      }

      // Update profile picture URL in user comments
      final userCommentsQuery = await firestore
          .collectionGroup('comments')
          .where('uID', isEqualTo: uID)
          .get();

      for (final commentDoc in userCommentsQuery.docs) {
        batch.update(commentDoc.reference, {'profilePic': photoUrl});
      }

      // Commit the batch
      await batch.commit();
    } catch (e) {
      // Handle any errors here.
      if (kDebugMode) {
        print('Error updating profile pic: $e');
      }
    }
  }

  Future<String> uploadNewProfilePic(String uID, String path) async {
    return await _storeFileToFirebase('profilePics/$uID', File(path));
  }

  @override
  Future<UserModel> getUserById(String uID) async {
    var userData = await firestore.collection('users').doc(uID).get();
    UserModel user = UserModel.fromJson(userData.data()!);
    return user;
  }

  @override
  Future<void> updateUserData(UserParams params) async {
    try {
      final uID = await getCurrentUID();

      // Get the current user data to compare the profile picture URL
      final currentUserData = await getUserData(uID);

      final batch = firestore.batch();

      if (params.profileUrl.isNotEmpty &&
          params.profileUrl != currentUserData.profilePic) {
        // Profile picture URL is not empty and different from the current one.
        await _updateProfilePic(params.profileUrl);
      }

      // Update user data in Firestore
      final userDocRef = firestore.collection('users').doc(uID);
      batch.update(userDocRef, {
        'username': params.username,
        'name': params.name,
        'bio': params.bio,
      });

      if (params.name != currentUserData.name) {
        // Update name in user posts
        final userPostsQuery = await firestore
            .collection('posts')
            .where('uID', isEqualTo: uID)
            .get();

        for (final postDoc in userPostsQuery.docs) {
          batch.update(postDoc.reference, {'name': params.name});
        }

        // Update name in user comments
        final userCommentsQuery = await firestore
            .collectionGroup('comments')
            .where('uID', isEqualTo: uID)
            .get();

        for (final commentDoc in userCommentsQuery.docs) {
          batch.update(commentDoc.reference, {'name': params.name});
        }
      }

      // Commit the batch
      await batch.commit();
    } catch (e) {
      // Handle any errors here.
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }

  @override
  Future<void> followUser(String followUserID) async {
    String uID = await getCurrentUID();
    final batch = firestore.batch();

    final currentUserRef = firestore.collection('users').doc(uID);
    batch.update(currentUserRef, {
      'following': FieldValue.arrayUnion([followUserID]),
    });

    final followedUserRef = firestore.collection('users').doc(followUserID);
    batch.update(followedUserRef, {
      'followers': FieldValue.arrayUnion([uID]),
    });

    await batch.commit();
  }

  @override
  Future<void> unFollowUser(String followUserID) async {
    String uID = await getCurrentUID();
    final batch = firestore.batch();

    final currentUserRef = firestore.collection('users').doc(uID);
    batch.update(currentUserRef, {
      'following': FieldValue.arrayRemove([followUserID]),
    });

    final followedUserRef = firestore.collection('users').doc(followUserID);
    batch.update(followedUserRef, {
      'followers': FieldValue.arrayRemove([uID]),
    });

    await batch.commit();
  }

  @override
  Future<void> deleteUserAccount() async {
    try {
      final uID = await getCurrentUID();
      final batch = firestore.batch();

      // Delete user's comments on posts
      await _deleteComments(uID, batch);

      // Remove user from followers and following lists
      await _removeUserFromFollowersAndFollowing(uID, batch);

      // Delete user's posts and related data
      await _deletePostsAndRelatedData(uID, batch);

      // Delete user's profile picture
      await _deleteProfilePicture(uID);

      // Delete user's Chats
      await _deleteUserChats(uID, batch);

      // Delete user's collection
      await firestore.collection('users').doc(uID).delete();

      // Delete the user's account
      await auth.currentUser!.delete();

      await batch.commit();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting user account: $e');
      }
    }
  }

  Future<void> _deletePostsAndRelatedData(String uID, WriteBatch batch) async {
    final postsSnapshot =
        await firestore.collection('posts').where('uID', isEqualTo: uID).get();

    for (final postDoc in postsSnapshot.docs) {
      final post = postDoc.data();

      if (post.containsKey('imageUrl') && post['imageUrl'].isNotEmpty) {
        await _deleteFileFromFirebase(post['imageUrl']);
      }

      if (post.containsKey('videoUrl') && post['videoUrl'].isNotEmpty) {
        await _deleteFileFromFirebase(post['videoUrl']);
      }

      postDoc.reference.delete();
    }

    final likesSnapshot = await firestore
        .collection('posts')
        .where('likes', arrayContains: uID)
        .get();

    for (final postDoc in likesSnapshot.docs) {
      batch.update(
        postDoc.reference,
        {
          'likes': FieldValue.arrayRemove([uID])
        },
      );
    }
  }

  Future<void> _deleteProfilePicture(String uID) async {
    final userSnapshot = await firestore.collection('users').doc(uID).get();
    final userData = userSnapshot.data() as Map<String, dynamic>;

    if (userData.containsKey('profilePic') &&
        userData['profilePic'].isNotEmpty) {
      await _deleteFileFromFirebase(userData['profilePic']);
    }
  }

  Future<void> _deleteComments(String uID, WriteBatch batch) async {
    final userCommentsQuery = await firestore
        .collectionGroup('comments')
        .where('uID', isEqualTo: uID)
        .get();

    for (final commentDoc in userCommentsQuery.docs) {
      commentDoc.reference.delete();
    }
  }

  Future<void> _removeUserFromFollowersAndFollowing(
      String uID, WriteBatch batch) async {
    final followersSnapshot = await firestore
        .collection('users')
        .where('following', arrayContains: uID)
        .get();

    for (final followerDoc in followersSnapshot.docs) {
      batch.update(
        followerDoc.reference,
        {
          'following': FieldValue.arrayRemove([uID])
        },
      );
    }

    final followingSnapshot = await firestore
        .collection('users')
        .where('followers', arrayContains: uID)
        .get();

    for (final followingDoc in followingSnapshot.docs) {
      batch.update(
        followingDoc.reference,
        {
          'followers': FieldValue.arrayRemove([uID])
        },
      );
    }
  }

  Future<void> _deleteUserChats(String uId, WriteBatch batch) async {
    final userChatsRef =
        firestore.collection('users').doc(uId).collection('chats');

    final chatDocs = await userChatsRef.get();

    if (chatDocs.docs.isEmpty) return; // No chats to delete

    for (final chatDoc in chatDocs.docs) {
      String otherUserId = chatDoc.id; // The other user's ID in this chat

      // Delete the chat document from the deleted user's collection
      batch.delete(chatDoc.reference);

      // Delete the corresponding chat from the other user's collection
      final otherUserChatRef = firestore
          .collection('users')
          .doc(otherUserId)
          .collection('chats')
          .doc(uId);

      batch.delete(otherUserChatRef);
    }

    await batch.commit();
  }
}
