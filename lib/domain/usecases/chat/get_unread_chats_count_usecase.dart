import '../../../../core/usecase/usecase.dart';
import '../../entities/message_entity.dart';
import '../../repositories/chat_repository.dart';

class GetChatMessagesUseCase
    implements StreamUseCase<List<MessageEntity>, String> {
  final ChatRepository _repository;

  GetChatMessagesUseCase(this._repository);

  @override
  Stream<List<MessageEntity>> call(String receiverId) =>
      _repository.getChatMessages(receiverId);
}
