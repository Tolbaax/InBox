import 'package:inbox/core/params/post/like_post_params.dart';
import 'package:inbox/core/params/post/post_params.dart';

import '../../../../core/params/post/comment_params.dart';
import '../../../domain/entities/comment_entity.dart';
import '../../../domain/entities/post_entity.dart';

abstract class PostRemoteDataSource {
  Future<void> createPost(PostParams params);

  Stream<List<PostEntity>> getPosts();

  Future<void> likePost(LikePostParams params);

  Future<void> addComment(CommentParams params);

  Stream<List<CommentEntity>> getComments(String postID);

  Future<void> deletePost(String postID);

  Future<void> savePost(String postID);

  Future<bool> isPostInDrafts(String postID);

  Stream<List<PostEntity>> getSavedPosts();

  Stream<List<PostEntity>> getMyPostsWithoutVideos(String uID);

  Stream<List<PostEntity>> getMyPostsWithVideos(String uID);
}
