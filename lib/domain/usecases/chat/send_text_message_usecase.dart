import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/chat/message_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/chat_repository.dart';

class SendTextMessageUseCase implements UseCase<void, MessageParams> {
  final ChatRepository _repository;

  SendTextMessageUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(MessageParams params) async =>
      await _repository.sendTextMessage(params);
}
