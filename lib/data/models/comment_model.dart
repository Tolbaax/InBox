import '../../domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.uID,
    required super.commentID,
    required super.commentText,
    required super.profilePic,
    required super.name,
    required super.publishTime,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        uID: json['uID'] ?? '',
        commentID: json['commentID'] ?? '',
        commentText: json['commentText'] ?? '',
        profilePic: json['profilePic'] ?? '',
        name: json['name'] ?? '',
        publishTime: json['publishTime'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'uID': uID,
        'commentID': commentID,
        'commentText': commentText,
        'profilePic': profilePic,
        'name': name,
        'publishTime': publishTime,
      };
}
