import '../../entities/user_chat_entity.dart';
import '../../repositories/chat_repository.dart';

class GetUsersChatUseCase {
  final ChatRepository _repository;

  GetUsersChatUseCase(this._repository);

  Stream<List<UserChatEntity>> call() => _repository.getUsersChat();
}
