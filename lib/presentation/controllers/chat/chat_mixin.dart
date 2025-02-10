import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import '../../../core/injection/injector.dart';
import '../../../domain/entities/message_entity.dart';
import 'chat_states.dart';

mixin ChatProviders on Cubit<ChatStates> {
  FocusNode chatFocusNode = FocusNode();
  FocusNode cameraFocusNode = FocusNode();

  bool isShowEmoji = false;
  bool isReplying = false;
  CroppedFile? messageImage;
  bool isSelecting = false;
  List<String> selectedMessageIds = [];
  String selectedReceiverId = '';

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
      selectedReceiverId = message.receiverId; // Set receiverId once
      selectedMessageIds.add(message.messageId);
      emit(SelectMessageState());
    } else {
      // Only allow selecting messages from the same receiver
      if (message.receiverId == selectedReceiverId) {
        selectedMessageIds.add(message.messageId);
        emit(SelectMessageState());
      }
    }
  }

  void handleMessageTap(MessageEntity message) {
    if (isSelecting) {
      if (selectedMessageIds.contains(message.messageId)) {
        selectedMessageIds.remove(message.messageId);
      } else {
        selectedMessageIds.add(message.messageId);
      }

      if (selectedMessageIds.isEmpty) {
        isSelecting = false;
      }
      emit(SelectMessageState());
    }
  }

  void removeSelected() {
    if (isSelecting) {
      selectedMessageIds.clear();
      isSelecting = false;
      selectedReceiverId = '';
      emit(SelectMessageState());
    }
  }

  bool _isPopping = false;

  Future<void> onPopInvokedWithResult(BuildContext context) async {
    if (_isPopping) return;
    _isPopping = true;

    if (isSelecting) {
      removeSelected();
      _isPopping = false;
      return;
    }

    if (isShowEmoji) hideEmojiContainer();
    if (isReplying) sl<ChatCubit>().cancelReply();

    if (Navigator.of(context).canPop()) navigatePop(context);

    _isPopping = false;
  }
}
