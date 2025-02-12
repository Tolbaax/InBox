import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';

import '../../../core/injection/injector.dart';
import '../../../core/params/chat/message_reply.dart';
import '../../../domain/entities/message_entity.dart';
import 'chat_states.dart';

mixin ChatProviders on Cubit<ChatStates> {
  FocusNode chatFocusNode = FocusNode();
  FocusNode cameraFocusNode = FocusNode();

  // Message Reply
  MessageReplay? messageReplay;

  bool isShowEmoji = false;
  bool isReplying = false;
  CroppedFile? messageImage;
  bool isSelecting = false;
  List<String> selectedMessageIds = [];
  List<String> selectedMessages = [];
  List<String> selectedSenders = [];
  String selectedReceiverId = '';
  bool isMyMessages = false;
  bool deleteForMeWithEveryOne = false;

  void onMessageReply(MessageReplay params) {
    emit(MessageSwipeLoadingState());
    messageReplay = params;
    isReplying = true;
    emit(MessageSwipeState());
  }

  void cancelReply() {
    messageReplay = null;
    isReplying = false;
    emit(CancelReplayState());
  }

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

  void handleMessageLongPress(MessageEntity message, String receiverId) {
    if (!isSelecting) {
      isSelecting = true;
      selectedReceiverId = receiverId;
      selectedMessageIds.add(message.messageId);
      isMyMessages = message.senderId == receiverId ? false : true;
      selectedSenders.add(message.senderId);
      selectedMessages.add(message.message);
      if (selectedMessageIds.length == 1) {
        messageReplay = MessageReplay(
          message: message.message,
          isMe: message.senderId == receiverId ? false : true,
          messageType: message.messageType,
          repliedTo: message.senderName,
        );
      }
      emit(SelectMessageState());
    }
  }

  void handleMessageTap(MessageEntity message) {
    if (isSelecting) {
      if (selectedMessageIds.contains(message.messageId)) {
        selectedMessageIds.remove(message.messageId);
        selectedSenders.remove(message.senderId);
        selectedMessages.remove(message.message);
        isReplying = false;
      } else {
        selectedMessageIds.add(message.messageId);
        selectedSenders.add(message.senderId);
        selectedMessages.add(message.message);
      }

      bool allEqual = selectedSenders.toSet().length == 1;
      isMyMessages =
          allEqual ? selectedSenders.first != selectedReceiverId : false;

      if (selectedMessageIds.isEmpty) {
        isSelecting = false;
        isMyMessages = false;
        selectedSenders.clear();
      }
      emit(SelectMessageState());
    }
  }

  Future<void> removeSelected() async {
    if (isSelecting) {
      selectedMessageIds.clear();
      selectedSenders.clear();
      selectedMessages.clear();
      isSelecting = false;
      selectedReceiverId = '';
      isReplying = false;
      isMyMessages = false;
      deleteForMeWithEveryOne = false;
      messageReplay = null;
      emit(SelectMessageState());
    }
  }

  Future<void> setDeleteForMeWithEveryOne(bool isMe) async {
    deleteForMeWithEveryOne = isMe;
    emit(SelectMessageState());
  }

  Future<void> setIsReply() async {
    isReplying = true;
    selectedMessageIds.clear();
    isSelecting = false;
    emit(SelectMessageState());
  }

  bool _isPopping = false;

  Future<void> onPopInvokedWithResult(BuildContext context) async {
    if (_isPopping) return; // Prevent multiple pop operations
    _isPopping = true;

    if (isSelecting) {
      await removeSelected();
      _isPopping = false;
      return;
    }

    if (isShowEmoji) hideEmojiContainer();
    if (isReplying) sl<ChatCubit>().cancelReply();

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    _isPopping = false;
  }
}
