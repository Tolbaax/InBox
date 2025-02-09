import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/chat/delete_message_params.dart';
import 'package:inbox/core/usecase/usecase.dart';
import '../../repositories/chat_repository.dart';

class DeleteMessagesUseCase implements UseCase<void, DeleteMessageParams> {
  final ChatRepository _repository;

  const DeleteMessagesUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(DeleteMessageParams params) {
    return _repository.deleteMessages(params);
  }
}
