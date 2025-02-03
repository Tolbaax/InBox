import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/params/post/comment_params.dart';
import '../../../../domain/entities/comment_entity.dart';
import '../../../../domain/usecases/post/add_comment_usecase.dart';
import '../../../../domain/usecases/post/get_comments_usecase.dart';
import 'comment_states.dart';

class CommentCubit extends Cubit<CommentStates> {
  final AddCommentUseCase _addCommentUseCase;
  final GetCommentsUseCase _getCommentsUseCase;

  CommentCubit(this._addCommentUseCase, this._getCommentsUseCase)
      : super(CommentInitialState());

  static CommentCubit get(context) => BlocProvider.of(context);

  Future<void> addComment(String postID, String commentText) async {
    emit(AddCommentLoadingState());
    final result = await _addCommentUseCase(
      CommentParams(
        postID: postID,
        commentText: commentText,
      ),
    );

    result.fold(
      (l) => emit(AddCommentErrorState()),
      (r) => emit(AddCommentSuccessState()),
    );
  }

  Future<List<CommentEntity>> getComments(String postID) async {
    emit(GetCommentsLoadingState());
    final List<CommentEntity> comments = [];
    try {
      final result = _getCommentsUseCase.call(postID);
      result.listen((comments) {
        emit(GetCommentsSuccessState(comments: comments));
        comments = comments;
      });
    } on SocketException catch (e) {
      emit(GetCommentsErrorState(error: e.toString()));
    }
    return comments;
  }
}
