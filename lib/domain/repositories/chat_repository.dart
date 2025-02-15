import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/chat/delete_message_params.dart';
import 'package:inbox/core/params/chat/set_chat_message_seen_params.dart';
import 'package:inbox/core/params/chat/message_params.dart';

import '../entities/message_entity.dart';
import '../entities/user_chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendTextMessage(MessageParams parameters);

  Future<Either<Failure, void>> sendFileMessage(MessageParams parameters);

  Future<Either<Failure, void>> sendGifMessage(MessageParams parameters);

  Stream<List<UserChatEntity>> getUsersChat();

  Stream<List<MessageEntity>> getChatMessages(String receiverId);

  Future<Either<Failure, void>> setChatMessageSeen(
      SetChatMessageSeenParams parameters);

  Stream<int> getNumOfMessageNotSeen(String senderId);

  Future<Either<Failure, void>> deleteMessages(DeleteMessageParams parameters);

  Future<Either<Failure, void>> deleteChat(List<String> selectedChatIds);
}
