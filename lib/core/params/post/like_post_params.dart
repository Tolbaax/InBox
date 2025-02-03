import 'package:equatable/equatable.dart';

class LikePostParams extends Equatable {
  final String postID;
  final List<dynamic> likes;

  const LikePostParams({
    required this.postID,
    required this.likes,
  });

  @override
  List<Object?> get props => [postID, likes];
}
