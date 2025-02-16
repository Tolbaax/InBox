import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/post/comment_params.dart';
import 'package:inbox/core/params/post/like_post_params.dart';
import 'package:inbox/core/params/post/post_params.dart';
import 'package:inbox/domain/entities/comment_entity.dart';
import 'package:inbox/domain/entities/post_entity.dart';

import '../../domain/repositories/post_repository.dart';
import '../datasources/post/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImpl({required this.postRemoteDataSource});

  @override
  Future<Either<Failure, void>> createPost(PostParams params) async {
    final result = await postRemoteDataSource.createPost(params);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Stream<List<PostEntity>> getPosts() => postRemoteDataSource.getPosts();

  @override
  Future<Either<Failure, void>> likePost(LikePostParams params) async {
    final result = await postRemoteDataSource.likePost(params);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> addComment(CommentParams params) async {
    final result = await postRemoteDataSource.addComment(params);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Stream<List<CommentEntity>> getComments(String postID) =>
      postRemoteDataSource.getComments(postID);

  @override
  Future<Either<Failure, void>> deletePost(String postID) async {
    final result = await postRemoteDataSource.deletePost(postID);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> savePost(String postID) async {
    final result = await postRemoteDataSource.savePost(postID);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> isPostInDrafts(String postID) async {
    final result = await postRemoteDataSource.isPostInDrafts(postID);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Stream<List<PostEntity>> getSavedPosts() =>
      postRemoteDataSource.getSavedPosts();

  @override
  Stream<List<PostEntity>> getMyPostsWithoutVideos(String uID) =>
      postRemoteDataSource.getMyPostsWithoutVideos(uID);

  @override
  Stream<List<PostEntity>> getMyPostsWithVideos(String uID) =>
      postRemoteDataSource.getMyPostsWithVideos(uID);

  @override
  Stream<PostEntity> getPostByPostID(String postID)  =>
       postRemoteDataSource.getPostByPostID(postID);
}
