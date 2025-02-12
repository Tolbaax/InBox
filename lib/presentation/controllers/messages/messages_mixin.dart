import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'messages_states.dart';

mixin MessagesMixin on Cubit<MessagesStates> {
  // Chat Selection State
  bool isChatSelecting = false;
  List<String> selectedChatIds = [];

  final searchController = TextEditingController();
  bool isTextFieldEmpty = false;

  void handleChatLongPress(String chatId) {
    if (!isChatSelecting) {
      isChatSelecting = true;
      selectedChatIds.add(chatId);
      emit(SelectChatState());
    }
  }

  void handleChatTap(String chatId) {
    if (isChatSelecting) {
      if (selectedChatIds.contains(chatId)) {
        selectedChatIds.remove(chatId);
      } else {
        selectedChatIds.add(chatId);
      }

      if (selectedChatIds.isEmpty) {
        isChatSelecting = false;
      }

      emit(SelectChatState());
    }
  }

  void removeSelectedChats() {
    selectedChatIds.clear();
    isChatSelecting = false;
    emit(SelectChatState());
  }

  void onSearchFieldChanged(value) {
    isTextFieldEmpty = true;
    emit(SelectChatState());
  }

  void clearSearchField() {
    searchController.clear();
    isTextFieldEmpty = false;
    emit(SelectChatState());
  }
}
