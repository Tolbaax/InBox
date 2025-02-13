import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_chat_model.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/user_chat_entity.dart';
import '../../../domain/usecases/chat/get_chat_messages_usecase.dart';
import '../../../domain/usecases/chat/get_num_of_message_not_seen_usecase.dart';
import '../../../domain/usecases/chat/get_users_chat_usecase.dart';
import 'messages_mixin.dart';
import 'messages_states.dart';

class MessagesCubit extends Cubit<MessagesState> with MessagesMixin {
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final GetUsersChatUseCase _getUsersChatUseCase;
  final GetNumberOfMessageNotSeenUseCase _getNumberOfMessageNotSeenUseCase;

  MessagesCubit(this._getChatMessagesUseCase, this._getUsersChatUseCase,
      this._getNumberOfMessageNotSeenUseCase)
      : super(MessagesInitial());

  static MessagesCubit get(context) => BlocProvider.of(context);

  Stream<List<UserChatEntity>> getUsersChats() => _getUsersChatUseCase.call();

  Stream<List<MessageEntity>> getChatMessages(String receiverId) =>
      _getChatMessagesUseCase.call(receiverId);

  Stream<int> getNumOfMessageNotSeen(String senderId) =>
      _getNumberOfMessageNotSeenUseCase.call(senderId);

  String get searchQuery => searchController.text.trim();


  Future<List<UserChatEntity>> searchUsers() async {
    if (searchQuery.isEmpty) return [];

    final querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .orderBy('name')
        .startAt([searchQuery]).endAt(["$searchQuery\uf8ff"]).get();

    return querySnapshot.docs
        .map((doc) => UserChatModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> close() {
    searchController.dispose();
    debounce?.cancel();
    return super.close();
  }
}
