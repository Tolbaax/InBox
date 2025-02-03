import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/chat/message_params.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/chat_repository.dart';

class SendGifMessageUseCase implements UseCase<void, MessageParams> {
  final ChatRepository _repository;

  SendGifMessageUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(MessageParams params) async =>
      await _repository.sendGifMessage(params);
}
