import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/params/post/like_post_params.dart';
import 'package:inbox/domain/entities/post_entity.dart';
import 'package:inbox/domain/usecases/post/delete_post_usecase.dart';
import 'package:inbox/domain/usecases/post/get_my_posts_with_videos_usecase.dart';
import 'package:inbox/domain/usecases/post/get_my_posts_without_videos_usecase.dart';
import 'package:inbox/domain/usecases/post/get_post_by_post_id_usecase.dart';
import 'package:inbox/domain/usecases/post/get_saved_posts_usecase.dart';
import 'package:inbox/domain/usecases/post/is_post_in_drafts_usecase.dart';
import 'package:inbox/domain/usecases/post/like_post_usecase.dart';
import 'package:inbox/domain/usecases/post/save_post_usecase.dart';

import '../../../domain/usecases/post/get_posts_usecase.dart';
import 'post_states.dart';

class PostCubit extends Cubit<PostStates> {
  final GetPostsUseCase _getPostsUseCase;
  final LikePostUseCase _likePostUseCase;
  final DeletePostUseCase _deletePostUseCase;
  final SavePostUseCase _savePostUseCase;
  final IsPostInDraftsUseCase _isPostInDraftsUseCase;
  final GetSavedPostsUseCase _getSavedPostsUseCase;
  final GetMyPostsWithoutVideos _getMyPostsWithoutVideos;
  final GetMyPostsWithVideos _getMyPostsWithVideos;
  final GetPostByPostIDUseCase _getPostByPostIDUseCase;

  PostCubit(
    this._getPostsUseCase,
    this._likePostUseCase,
    this._deletePostUseCase,
    this._savePostUseCase,
    this._isPostInDraftsUseCase,
    this._getSavedPostsUseCase,
    this._getMyPostsWithoutVideos,
    this._getMyPostsWithVideos,
    this._getPostByPostIDUseCase,
  ) : super(PostInitialStates());

  static PostCubit get(context) => BlocProvider.of(context);

  Stream<List<PostEntity>> getPosts() {
    try {
      return _getPostsUseCase.call();
    } catch (error) {
      emit(GetPostsErrorState(msg: error.toString()));
      return const Stream.empty();
    }
  }

  Future<void> likePost(LikePostParams params) async {
    final result = await _likePostUseCase.call(params);

    result.fold(
      (l) {
        emit(LikePostErrorState());
        AppDialogs.showToast(msg: l.toString());
      },
      (r) => emit(LikePostSuccessState()),
    );
  }

  Future<void> deletePost(String postID) async {
    emit(DeletePostLoadingState());
    final result = await _deletePostUseCase.call(postID);

    result.fold(
      (l) {
        emit(DeletePostErrorState(msg: l.toString()));
        AppDialogs.showToast(msg: l.toString());
      },
      (r) => emit(DeletePostSuccessState()),
    );
  }

  Future<void> savePost(String postID) async {
    final result = await _savePostUseCase.call(postID);

    result.fold(
      (l) => emit(SaveUnSavePostErrorState(msg: l.toString())),
      (r) => emit(SaveUnSavePostState()),
    );
  }

  Future<bool> isPostInDrafts(String postID) async {
    final result = await _isPostInDraftsUseCase.call(postID);

    return result.fold((l) => false, (r) => r);
  }

  Stream<List<PostEntity>> getSavedPosts() {
    try {
      return _getSavedPostsUseCase.call();
    } catch (error) {
      emit(GetSavedPostsErrorState(msg: error.toString()));
      return const Stream.empty();
    }
  }

  Stream<List<PostEntity>> getMyPostsWithoutVideos(String uID) {
    try {
      return _getMyPostsWithoutVideos.call(uID);
    } catch (error) {
      emit(GetMyPostsWithoutVideosError(msg: error.toString()));
      return const Stream.empty();
    }
  }

  Stream<List<PostEntity>> getMyPostsWithVideos(String uID) {
    try {
      return _getMyPostsWithVideos.call(uID);
    } catch (error) {
      emit(GetMyPostsWithVideosError(msg: error.toString()));
      return const Stream.empty();
    }
  }

  Stream<PostEntity> getPostByPostID(String postID) {
    try {
      return _getPostByPostIDUseCase.call(postID);
    } catch (error) {
      emit(GetPostsErrorState(msg: error.toString()));
      return const Stream.empty();
    }
  }
}
