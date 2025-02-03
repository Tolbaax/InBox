import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/params/chat/set_chat_message_seen_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/chat_repository.dart';

class SetChatMessageSeenUseCase extends UseCase<void, SetChatMessageSeenParams> {
  final ChatRepository _repository;

  SetChatMessageSeenUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(
          SetChatMessageSeenParams params) async =>
      await _repository.setChatMessageSeen(params);
}
