import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'chat_states.dart';

mixin ChatProviders on Cubit<ChatStates> {
  FocusNode chatFocusNode = FocusNode();
  FocusNode cameraFocusNode = FocusNode();

  bool isShowEmoji = false;
  CroppedFile? messageImage;

  void showEmojiContainer() {
    isShowEmoji = true;
    emit(ShowEmojiContainerState());
  }

  void hideEmojiContainer() {
    isShowEmoji = false;
    emit(HideEmojiContainerState());
  }

  void toggleEmojiKeyboard(bool isCameraRev) {
    if (isShowEmoji) {
      isCameraRev
          ? cameraFocusNode.requestFocus()
          : chatFocusNode.requestFocus();
      hideEmojiContainer();
    } else {
      isCameraRev ? cameraFocusNode.unfocus() : chatFocusNode.unfocus();
      showEmojiContainer();
    }
  }
}
