import 'dart:io';
import 'package:equatable/equatable.dart';

class PostParams extends Equatable {
  final String postText;
  final File? imageFile;
  final File? videoFile;
  final String? gifUrl;

  const PostParams({
    required this.postText,
    this.imageFile,
    this.videoFile,
    this.gifUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [postText, imageFile, videoFile, gifUrl];
}
