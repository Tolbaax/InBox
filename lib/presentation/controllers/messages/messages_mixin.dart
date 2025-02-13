import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/injection/injector.dart';
import 'messages_states.dart';

mixin MessagesMixin on Cubit<MessagesState> {
  // Chat Selection State
  bool isChatSelecting = false;
  List<String> selectedChatIds = [];
  Timer? debounce;

  final TextEditingController searchController = TextEditingController();
  bool isTextFieldEmpty = true;

  final FirebaseFirestore firestore = sl<FirebaseFirestore>();
  final FirebaseAuth firebaseAuth = sl<FirebaseAuth>();

  void onSearchFieldChanged(String value) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 400), () {
      isTextFieldEmpty = value.isEmpty;
      if (selectedChatIds.isNotEmpty) selectedChatIds.clear();
      emit(MessagesSearchUpdated());
    });
  }

  void clearSearchField() {
    searchController.clear();
    isTextFieldEmpty = true;
    emit(MessagesSearchUpdated());
  }

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
    emit(RemoveSelectedState());
  }
}
