import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String uID;
  final String postID;
  final String postText;
  final String profilePic;
  final String name;
  final String imageUrl;
  final String videoUrl;
  final String gifUrl;
  final List<dynamic> likes;
  final int commentCount;
  final String publishTime;

  const PostEntity({
    required this.uID,
    required this.postID,
    required this.postText,
    required this.name,
    required this.profilePic,
    required this.imageUrl,
    required this.videoUrl,
    required this.gifUrl,
    required this.likes,
    required this.commentCount,
    required this.publishTime,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        uID,
        postID,
        postText,
        name,
        profilePic,
        imageUrl,
        videoUrl,
        gifUrl,
        likes,
        commentCount,
        publishTime,
      ];
}
