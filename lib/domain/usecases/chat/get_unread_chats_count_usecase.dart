import '../../repositories/chat_repository.dart';

class GetUnReadChatsCountUseCase {
  final ChatRepository _repository;

  GetUnReadChatsCountUseCase(this._repository);

  Stream<int> call() => _repository.getUnreadChatsCount();
}
