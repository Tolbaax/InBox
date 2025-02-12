import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/params/chat/delete_message_params.dart';
import 'package:inbox/core/params/chat/set_chat_message_seen_params.dart';
import 'package:inbox/core/params/chat/message_params.dart';
import 'package:inbox/domain/usecases/chat/delete_message_usecase.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/usecases/chat/get_chat_messages_usecase.dart';
import '../../../domain/usecases/chat/send_file_message_usecase.dart';
import '../../../domain/usecases/chat/send_gif_message_usecase.dart';
import '../../../domain/usecases/chat/send_text_message_usecase.dart';
import '../../../domain/usecases/chat/set_chat_message_seen.dart';
import 'chat_mixin.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> with ChatProviders {
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SetChatMessageSeenUseCase _setChatMessageSeenUseCase;
  final SendGifMessageUseCase _sendGifMessageUseCase;
  final SendFileMessageUseCase _sendFileMessageUseCase;
  final DeleteMessagesUseCase _deleteMessagesUseCase;

  ChatCubit(
    this._sendTextMessageUseCase,
    this._getChatMessagesUseCase,
    this._setChatMessageSeenUseCase,
    this._sendGifMessageUseCase,
    this._sendFileMessageUseCase,
    this._deleteMessagesUseCase,
  ) : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

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

  Future<void> setChatMessageSeen(SetChatMessageSeenParams params) async {
    final result = await _setChatMessageSeenUseCase.call(params);

    result.fold(
      (l) => emit(SetMessageSeenErrorState()),
      (r) => emit(SetMessageSeenSuccessState()),
    );
  }

  Future<void> deleteMessages(DeleteMessageParams params) async {
    emit(DeleteMessageLoadingState());

    final result = await _deleteMessagesUseCase(params);

    result.fold(
      (l) => emit(DeleteMessageErrorState()),
      (r) => emit(DeleteMessageSuccessState()),
    );
  }
}
