import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String uID;
  final String commentID;
  final String commentText;
  final String profilePic;
  final String name;
  final String publishTime;

  const CommentEntity({
    required this.uID,
    required this.commentID,
    required this.commentText,
    required this.profilePic,
    required this.name,
    required this.publishTime,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        uID,
        commentID,
        commentText,
        profilePic,
        name,
        publishTime,
      ];
}
