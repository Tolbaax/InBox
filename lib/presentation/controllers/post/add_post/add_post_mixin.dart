import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/functions/app_dialogs.dart';
import '../../../../../core/shared/common.dart';
import 'add_post_states.dart';

mixin AddPostMixin on Cubit<AddPostStates> {
  final postTextController = TextEditingController();
  VideoPlayerController? videoPlayerController;
  File? postImage;
  GiphyGif? gif;
  String? gifUrl;
  File? video;

  Future<void> pickImage(BuildContext context) async {
    final pickedFile = await pickImageFile(context);
    if (pickedFile != null) {
      if (video != null) disposeVideo();
      if (gif != null) disposeGif();
      cropImage(pickedFile.path, title: 'Post Image').then((value) {
        if (value != null) {
          postImage = File(value.path);
          emit(PickPostImageSuccessState());
        }
      });
    }
  }

  Future<void> getPostImageFromCamera(BuildContext context) async {
    final pickedImage =
        await pickImageFile(context, imageSource: ImageSource.camera);

    if (pickedImage != null) {
      postImage = pickedImage;
      emit(PickPostImageSuccessState());
    } else {
      if (kDebugMode) {
        print('Error: The pickedImage is null.');
      }
    }
    if (video != null) disposeVideo();
    if (gif != null) disposeGif();
  }

  Future<void> pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 30),
    );
    if (pickedFile != null) {
      video = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          videoPlayerController!.play();
          emit(PickVideoSuccessState(video: video!));
        });
      if (postImage != null) deletePostImage();
      if (gif != null) disposeGif();
    }
  }

  Future<void> pickGifUrl(BuildContext context) async {
    try {
      gif = await GiphyGet.getGif(
        context: context,
        apiKey: 'dsW7gRQ0OrEqegEYi9Xh8MeOjFwuiZTW',
      );
      if (gif != null) {
        gifUrl = gif!.images?.original?.url;
        emit(PickedGifSuccessState());
      } else {
        emit(PickedGifErrorState());
      }
    } catch (e) {
      AppDialogs.showToast(msg: e.toString());
    }

    if (postImage != null) deletePostImage();
    if (video != null) disposeVideo();
  }

  void deletePostImage() {
    postImage = null;
    emit(DeletePostImageState());
  }

  void disposeVideo() {
    video = null;
    videoPlayerController?.dispose();
    videoPlayerController = null;
    emit(DisposeVideoState());
  }

  void disposeGif() {
    gif = null;
    emit(DisposeGifState());
  }
}
