import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:inbox/core/params/post/comment_params.dart';
import 'package:inbox/core/params/post/like_post_params.dart';
import 'package:inbox/core/params/post/post_params.dart';
import 'package:inbox/data/models/comment_model.dart';
import 'package:inbox/data/models/post_model.dart';
import 'package:inbox/domain/entities/comment_entity.dart';
import 'package:inbox/domain/entities/post_entity.dart';

import '../user/user_remote_data_source.dart';
import 'post_remote_data_source.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  final UserRemoteDataSource userRemoteDataSource;

  PostRemoteDataSourceImpl(
    this.auth,
    this.firestore,
    this.firebaseStorage,
    this.userRemoteDataSource,
  );

  @override
  Future<void> createPost(PostParams params) async {
    final userData = await userRemoteDataSource.getCurrentUser();
    final postDocRef = firestore.collection('posts').doc();
    final postId = postDocRef.id;

    final imageUrl =
        await _uploadFileToFirebase('posts/images/$postId', params.imageFile);

    final videoUrl =
        await _uploadFileToFirebase('posts/videos/$postId', params.videoFile);

    final post = PostModel(
      uID: userData.uID,
      postID: postId,
      postText: params.postText,
      name: userData.name,
      profilePic: userData.profilePic,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      gifUrl: params.gifUrl ?? '',
      likes: const [],
      commentCount: 0,
      publishTime: DateTime.now().toString(),
    );

    await postDocRef.set(post.toJson());

    await _updatePostCount();
  }

  Future<void> _updatePostCount() async {
    final uID = await userRemoteDataSource.getCurrentUID();
    final userRef = firestore.collection('users').doc(uID);

    // Retrieve all posts for the current user from the "posts" collection
    QuerySnapshot postSnapshot =
        await firestore.collection('posts').where('uID', isEqualTo: uID).get();

    // Get the count of posts for the user
    int postsCount = postSnapshot.size;

    // Update the "postCount" field in the user's document
    await userRef.update({'postsCount': postsCount});
  }

  Future<String> _uploadFileToFirebase(String path, File? file) async {
    if (file == null) return '';

    final uploadTask = firebaseStorage.ref().child(path).putFile(file);
    final snap = await uploadTask;
    final downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Stream<List<PostEntity>> getPosts() {
    final postCollection =
        firestore.collection('posts').orderBy("publishTime", descending: true);

    final posts = postCollection.snapshots().map((event) {
      List<PostModel> postList =
          event.docs.map((e) => PostModel.fromJson(e.data())).toList();

      return postList;
    });

    return posts;
  }

  @override
  Future<void> likePost(LikePostParams params) async {
    final uID = await userRemoteDataSource.getCurrentUID();
    final postDocRef = firestore.collection('posts').doc(params.postID);

    if (params.likes.contains(uID)) {
      // User already liked the post, remove their like
      await postDocRef.update({
        'likes': FieldValue.arrayRemove([uID]),
      });
    } else {
      // User hasn't liked the post yet, add their like
      await postDocRef.update({
        'likes': FieldValue.arrayUnion([uID]),
      });
    }
  }

  @override
  Future<void> addComment(CommentParams params) async {
    final userData = await userRemoteDataSource.getCurrentUser();

    final commentDocRef = firestore
        .collection('posts')
        .doc(params.postID)
        .collection('comments')
        .doc();
    final commentID = commentDocRef.id;

    CommentModel comment = CommentModel(
      uID: userData.uID,
      commentID: commentID,
      commentText: params.commentText,
      profilePic: userData.profilePic,
      name: userData.name,
      publishTime: DateTime.now().toString(),
    );

    await commentDocRef.set(comment.toJson());
    _updateCommentCount(params.postID);
  }

  Future<void> _updateCommentCount(String postID) async {
    final commentCollection =
        firestore.collection('posts').doc(postID).collection('comments');

    final querySnapshot = await commentCollection.get();
    final commentCount = querySnapshot.docs.length;

    await firestore.collection('posts').doc(postID).update({
      'commentCount': commentCount,
    });
  }

  @override
  Stream<List<CommentEntity>> getComments(String postID) {
    final commentCollection = firestore
        .collection('posts')
        .doc(postID)
        .collection('comments')
        .orderBy("publishTime", descending: true);

    final comments = commentCollection.snapshots().map((event) =>
        event.docs.map((e) => CommentModel.fromJson(e.data())).toList());

    // Use a variable to track if _updateCommentCount has been called
    bool isUpdateCountCalled = false;

    return comments.map((commentList) {
      // Check if _updateCommentCount has not been called yet
      if (!isUpdateCountCalled) {
        _updateCommentCount(postID);
        isUpdateCountCalled = true;
      }
      return commentList;
    });
  }

  Future<PostModel> _getPostById(String postID) async {
    final postDoc = await firestore.collection('posts').doc(postID).get();

    PostModel post = PostModel.fromJson(postDoc.data()!);
    return post;
  }

  Future<void> _deleteFileFromFirebase(String path) async {
    return await firebaseStorage.refFromURL(path).delete();
  }

  @override
  Future<void> deletePost(String postID) async {
    final batch = firestore.batch();
    final postCollection = firestore.collection('posts').doc(postID);
    final commentsCollection =
        await postCollection.collection('comments').get();
    final post = await _getPostById(postID);

    if (post.imageUrl.isNotEmpty) {
      await _deleteFileFromFirebase(post.imageUrl);
    }
    if (post.videoUrl.isNotEmpty) {
      await _deleteFileFromFirebase(post.videoUrl);
    }

    for (DocumentSnapshot docSnapshot in commentsCollection.docs) {
      batch.delete(docSnapshot.reference);
    }

    batch.delete(postCollection);

    // Commit all batch operations at once
    batch.commit();

    await _updatePostCount();
  }

  @override
  Future<bool> isPostInDrafts(String postID) async {
    final uID = await userRemoteDataSource.getCurrentUID();

    final userDocRef = firestore.collection('users').doc(uID);

    final userDoc = await userDocRef.get();
    final drafts = userDoc.data()!['drafts'] ?? [];

    return drafts.contains(postID);
  }

  @override
  Future<void> savePost(String postID) async {
    final uID = await userRemoteDataSource.getCurrentUID();

    final userDocRef = firestore.collection('users').doc(uID);
    final batch = firestore.batch();

    if (await isPostInDrafts(postID)) {
      // post ID exists in drafts, remove it
      batch.update(userDocRef, {
        'drafts': FieldValue.arrayRemove([postID]),
      });
    } else {
      // post ID does not exist in drafts, add it
      batch.update(userDocRef, {
        'drafts': FieldValue.arrayUnion([postID]),
      });
    }

    // Commit the batch
    await batch.commit();
  }

  @override
  Stream<List<PostEntity>> getSavedPosts() async* {
    final uID = await userRemoteDataSource.getCurrentUID();
    final userDocRef = firestore.collection('users').doc(uID);

    yield* userDocRef.snapshots().asyncMap((snapshot) async {
      final postIds = List<String>.from(snapshot.get('drafts') ?? []);
      final postDocs = await firestore
          .collection('posts')
          .where(FieldPath.documentId, whereIn: postIds)
          .get();

      final postList =
          postDocs.docs.map((doc) => PostModel.fromJson(doc.data())).toList();

      return postList.reversed.toList();
    });
  }

  @override
  Stream<List<PostEntity>> getMyPostsWithoutVideos(String uID) {
    final postCollection =
        firestore.collection('posts').orderBy("publishTime", descending: true);

    return postCollection.snapshots().map((snapshot) {
      final myPosts = snapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()))
          .where((post) => post.uID == uID && post.videoUrl.isEmpty)
          .toList();

      return myPosts;
    });
  }

  @override
  Stream<List<PostEntity>> getMyPostsWithVideos(String uID) {
    final postCollection =
        firestore.collection('posts').orderBy("publishTime", descending: true);

    return postCollection.snapshots().map((snapshot) {
      final myPosts = snapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()))
          .where((post) => post.uID == uID && post.videoUrl.isNotEmpty)
          .toList();

      return myPosts;
    });
  }
}
