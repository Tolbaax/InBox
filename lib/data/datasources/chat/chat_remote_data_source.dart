import 'package:inbox/core/params/chat/delete_message_params.dart';

import '../../../../core/params/chat/set_chat_message_seen_params.dart';
import '../../../../core/params/chat/message_params.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/user_chat_entity.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendTextMessage(MessageParams parameters);

  Future<void> sendFileMessage(MessageParams parameters);

  Future<void> sendGifMessage(MessageParams parameters);

  Stream<List<UserChatEntity>> getUsersChat();

  Stream<List<MessageEntity>> getChatMessages(String receiverId);

  Future<void> setChatMessageSeen(SetChatMessageSeenParams parameters);

  Stream<int> getNumOfMessageNotSeen(String senderId);

  Future<void> deleteMessages(DeleteMessageParams parameters);

  Future<void> deleteChat(List<String> selectedChatIds);

  Stream<int> getUnreadChatsCount();
}
