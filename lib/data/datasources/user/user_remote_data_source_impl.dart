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

      // Fetch user document first to ensure user exists
      final userRef = firestore.collection('users').doc(uID);
      final userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        throw Exception("User document not found.");
      }

      // Execute all deletions in parallel
      await Future.wait([
        _deleteComments(uID, batch),
        _removeUserFromFollowersAndFollowing(uID, batch),
        _deletePostsAndRelatedData(uID, batch),
        _deleteProfilePicture(userSnapshot.data() as Map<String, dynamic>),
        _deleteUserChats(uID, batch),
      ]);

      await batch.commit();

      await userRef.delete();

      await auth.currentUser?.delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting user account: $e');
      }
      throw Exception("Failed to delete user account.");
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

      batch.delete(postDoc.reference);
    }

    final likesSnapshot = await firestore
        .collection('posts')
        .where('likes', arrayContains: uID)
        .get();

    for (final postDoc in likesSnapshot.docs) {
      batch.update(postDoc.reference, {
        'likes': FieldValue.arrayRemove([uID])
      });
    }
  }

// Deletes profile picture if it exists
  Future<void> _deleteProfilePicture(Map<String, dynamic> userData) async {
    if (userData.containsKey('profilePic') &&
        userData['profilePic'].isNotEmpty) {
      await _deleteFileFromFirebase(userData['profilePic']);
    }
  }

// Deletes all comments made by the user
  Future<void> _deleteComments(String uID, WriteBatch batch) async {
    final userCommentsQuery = await firestore
        .collectionGroup('comments')
        .where('uID', isEqualTo: uID)
        .get();

    for (final commentDoc in userCommentsQuery.docs) {
      batch.delete(commentDoc.reference);
    }
  }

// Removes user from followers & following lists
  Future<void> _removeUserFromFollowersAndFollowing(
      String uID, WriteBatch batch) async {
    final followersSnapshot = await firestore
        .collection('users')
        .where('following', arrayContains: uID)
        .get();
    for (final followerDoc in followersSnapshot.docs) {
      batch.update(followerDoc.reference, {
        'following': FieldValue.arrayRemove([uID])
      });
    }

    final followingSnapshot = await firestore
        .collection('users')
        .where('followers', arrayContains: uID)
        .get();
    for (final followingDoc in followingSnapshot.docs) {
      batch.update(followingDoc.reference, {
        'followers': FieldValue.arrayRemove([uID])
      });
    }
  }

// Deletes all user chats
  Future<void> _deleteUserChats(String uID, WriteBatch batch) async {
    final userChatsRef =
        firestore.collection('users').doc(uID).collection('chats');
    final chatDocs = await userChatsRef.get();

    for (final chatDoc in chatDocs.docs) {
      String otherUserId = chatDoc.id;

      batch.delete(chatDoc.reference);

      final otherUserChatRef = firestore
          .collection('users')
          .doc(otherUserId)
          .collection('chats')
          .doc(uID);
      batch.delete(otherUserChatRef);
    }
  }
}
