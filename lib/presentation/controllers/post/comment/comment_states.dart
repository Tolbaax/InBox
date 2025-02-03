import '../../../../domain/entities/comment_entity.dart';

abstract class CommentStates {}

class CommentInitialState extends CommentStates {}

class AddCommentLoadingState extends CommentStates {}

class AddCommentSuccessState extends CommentStates {}

class AddCommentErrorState extends CommentStates {}

class GetCommentsLoadingState extends CommentStates {}

class GetCommentsSuccessState extends CommentStates {
  final List<CommentEntity> comments;

  GetCommentsSuccessState({required this.comments});
}

class GetCommentsErrorState extends CommentStates {
  final String error;

  GetCommentsErrorState({required this.error});
}
