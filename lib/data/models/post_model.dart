import 'package:inbox/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.uID,
    required super.postID,
    required super.postText,
    required super.name,
    required super.profilePic,
    required super.imageUrl,
    required super.videoUrl,
    required super.gifUrl,
    required super.likes,
    required super.commentCount,
    required super.publishTime,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        uID: json['uID'] ?? '',
        postID: json['postID'] ?? '',
        postText: json['postText'] ?? '',
        name: json['name'] ?? '',
        profilePic: json['profilePic'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        videoUrl: json['videoUrl'] ?? '',
        gifUrl: json['gifUrl'] ?? '',
        likes: json['likes'] ?? [],
        commentCount: json['commentCount'] ?? 0,
        publishTime: json['publishTime'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'uID': uID,
        'postID': postID,
        'postText': postText,
        'name': name,
        'profilePic': profilePic,
        'imageUrl': imageUrl,
        'videoUrl': videoUrl,
        'gifUrl': gifUrl,
        'likes': likes,
        'commentCount': commentCount,
        'publishTime': publishTime,
      };
}
