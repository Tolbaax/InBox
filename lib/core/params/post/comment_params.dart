import 'package:equatable/equatable.dart';

class CommentParams extends Equatable {
  final String postID;
  final String commentText;

  const CommentParams({
    required this.postID,
    required this.commentText,
  });

  @override
  List<Object?> get props => [postID, commentText];
}
