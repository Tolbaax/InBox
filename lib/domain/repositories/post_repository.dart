import 'package:dartz/dartz.dart';
import 'package:inbox/core/params/post/like_post_params.dart';
import 'package:inbox/core/params/post/post_params.dart';
import 'package:inbox/domain/entities/comment_entity.dart';
import 'package:inbox/domain/entities/post_entity.dart';

import '../../../core/error/failure.dart';
import '../../../core/params/post/comment_params.dart';

abstract class PostRepository {
  Future<Either<Failure, void>> createPost(PostParams params);

  Stream<List<PostEntity>> getPosts();

  Future<Either<Failure, void>> likePost(LikePostParams params);

  Future<Either<Failure, void>> addComment(CommentParams params);

  Stream<List<CommentEntity>> getComments(String postID);

  Future<Either<Failure, void>> deletePost(String postID);

  Future<Either<Failure, void>> savePost(String postID);

  Future<Either<Failure, bool>> isPostInDrafts(String postID);

  Stream<List<PostEntity>> getSavedPosts();

  Stream<List<PostEntity>> getMyPostsWithoutVideos(String uID);

  Stream<List<PostEntity>> getMyPostsWithVideos(String uID);
}
