import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/params/chat/delete_message_params.dart';
import 'package:inbox/core/params/chat/message_reply.dart';
import 'package:inbox/core/params/chat/set_chat_message_seen_params.dart';
import 'package:inbox/core/params/chat/message_params.dart';
import 'package:inbox/domain/usecases/chat/delete_message_usecase.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/user_chat_entity.dart';
import '../../../domain/usecases/chat/get_chat_messages_usecase.dart';
import '../../../domain/usecases/chat/get_num_of_message_not_seen_usecase.dart';
import '../../../domain/usecases/chat/get_users_chat_usecase.dart';
import '../../../domain/usecases/chat/send_file_message_usecase.dart';
import '../../../domain/usecases/chat/send_gif_message_usecase.dart';
import '../../../domain/usecases/chat/send_text_message_usecase.dart';
import '../../../domain/usecases/chat/set_chat_message_seen.dart';
import 'chat_mixin.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> with ChatProviders {
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final GetUsersChatUseCase _getUsersChatUseCase;
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SetChatMessageSeenUseCase _setChatMessageSeenUseCase;
  final SendGifMessageUseCase _sendGifMessageUseCase;
  final SendFileMessageUseCase _sendFileMessageUseCase;
  final GetNumberOfMessageNotSeenUseCase _getNumberOfMessageNotSeenUseCase;
  final DeleteMessagesUseCase _deleteMessagesUseCase;

  ChatCubit(
    this._sendTextMessageUseCase,
    this._getUsersChatUseCase,
    this._getChatMessagesUseCase,
    this._setChatMessageSeenUseCase,
    this._sendGifMessageUseCase,
    this._sendFileMessageUseCase,
    this._getNumberOfMessageNotSeenUseCase,
    this._deleteMessagesUseCase,
  ) : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  // Message Reply
  MessageReplay? messageReplay;

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

  Future<void> sendTextMessage(MessageParams params) async {
    emit(SendMessageLoadingState());
    messageReplay = null;

    final result = await _sendTextMessageUseCase.call(params);

    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  Future<void> sendGifMessage(MessageParams params) async {
    final result = await _sendGifMessageUseCase(params);
    messageReplay = null;

    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  Future<void> sendFileMessage(MessageParams params) async {
    final result = await _sendFileMessageUseCase(params);
    messageReplay = null;

    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  Stream<List<MessageEntity>> getChatMessages(String receiverId) =>
      _getChatMessagesUseCase.call(receiverId);

  Stream<List<UserChatEntity>> getUsersChats() => _getUsersChatUseCase.call();

  Future<void> setChatMessageSeen(SetChatMessageSeenParams params) async {
    final result = await _setChatMessageSeenUseCase.call(params);

    result.fold(
      (l) => emit(SetMessageSeenErrorState()),
      (r) => emit(SetMessageSeenSuccessState()),
    );
  }

  Stream<int> getNumOfMessageNotSeen(String senderId) =>
      _getNumberOfMessageNotSeenUseCase.call(senderId);

  Future<void> deleteMessages(DeleteMessageParams params) async {
    emit(DeleteMessageLoadingState());

    final result = await _deleteMessagesUseCase(params);

    result.fold(
      (l) => emit(DeleteMessageErrorState()),
      (r) => emit(DeleteMessageSuccessState()),
    );
  }
}
