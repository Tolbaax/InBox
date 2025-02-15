import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';
import '../../repositories/chat_repository.dart';

class DeleteChatUseCase implements UseCase<void, List<String>> {
  final ChatRepository _repository;

  const DeleteChatUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(List<String> selectedChatIds) {
    return _repository.deleteChat(selectedChatIds);
  }
}
