import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:inbox/core/functions/navigator.dart';
import '../../../domain/entities/message_entity.dart';
import 'chat_states.dart';

mixin ChatProviders on Cubit<ChatStates> {
  FocusNode chatFocusNode = FocusNode();
  FocusNode cameraFocusNode = FocusNode();

  bool isShowEmoji = false;
  CroppedFile? messageImage;
  bool isSelecting = false;
  late List<String> selectedMessages = [];

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

  void handleMessageLongPress(MessageEntity message) {
    if (!isSelecting) {
      isSelecting = true;
      selectedMessages.add(message.messageId);
      emit(SelectMessageState());
      emit(SelectMessageState());
    }
  }

  void handleMessageTap(MessageEntity message) {
    if (isSelecting) {
      selectedMessages.contains(message.messageId)
          ? selectedMessages.remove(message.messageId)
          : selectedMessages.add(message.messageId);
      if (selectedMessages.isEmpty) isSelecting = false;
      emit(SelectMessageState());
    }
  }

  void removeSelected() {
    if (isSelecting) {
      selectedMessages = [];
      if (selectedMessages.isEmpty) isSelecting = false;
      emit(SelectMessageState());
    }
  }

  Future<void> onPopInvokedWithResult(context) async {
    if (isSelecting) {
      selectedMessages = [];
      if (selectedMessages.isEmpty) isSelecting = false;
      emit(SelectMessageState());
    } else {
      navigatePop(context);
    }
  }
}
