import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/functions/app_dialogs.dart';
import '../../../../../core/shared/common.dart';
import '../../../../core/functions/navigator.dart';
import 'add_post_states.dart';

mixin AddPostMixin on Cubit<AddPostStates> {
  final postTextController = TextEditingController();
  VideoPlayerController? videoPlayerController;
  bool isEmpty = true;
  File? postImage;
  GiphyGif? gif;
  String? gifUrl;
  File? video;

  Future<void> pickImage(BuildContext context) async {
    if (!await requestPermission(Permission.storage)) {
      AppDialogs.showToast(
          msg: 'Storage permission denied', gravity: ToastGravity.BOTTOM);
      return;
    }

    if (context.mounted) {
      final pickedFile = await pickImageFile(context);
      if (pickedFile != null) {
        await deleteFile(postImage);
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
  }

  Future<void> getPostImageFromCamera(BuildContext context) async {
    if (!await requestPermission(Permission.camera)) {
      AppDialogs.showToast(msg: 'Camera permission denied');
      return;
    }

    if (context.mounted) {
      final pickedImage =
          await pickImageFile(context, imageSource: ImageSource.camera);
      if (pickedImage != null) {
        await deleteFile(postImage);
        if (video != null) disposeVideo();
        if (gif != null) disposeGif();

        cropImage(pickedImage.path, title: 'Post Image').then((value) {
          if (value != null) {
            postImage = File(value.path);
            emit(PickPostImageSuccessState());
          }
        });
      }
    }
  }

  Future<void> pickVideo() async {
    if (!await requestPermission(Permission.storage)) {
      AppDialogs.showToast(msg: 'Storage permission denied');
      return;
    }

    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 15),
    );

    if (pickedFile != null) {
      await deleteFile(video); // Delete previous video
      video = File(pickedFile.path);

      videoPlayerController = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          videoPlayerController!.play();
          emit(PickVideoSuccessState(video: video!));
        });

      if (postImage != null) disposePostImage();
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

    if (postImage != null) disposePostImage();
    if (video != null) disposeVideo();
  }

  void disposePostImage() async {
    deleteFile(postImage);
    postImage = null;
    emit(DeletePostImageState());
  }

  void disposeVideo() async {
    deleteFile(video);
    video = null;
    videoPlayerController?.dispose();
    videoPlayerController = null;
    emit(DisposeVideoState());
  }

  void disposeGif() async {
    gif = null;
    emit(DisposeGifState());
  }

  Future<void> onPopInvokedWithResult(context, cubit, isMedia) async {
    if (isMedia || !isEmpty) {
      AppDialogs.showDiscardPostDialog(context, cubit);
    } else {
      navigatePop(context);
    }
  }
}
