import 'package:inbox/core/usecase/usecase.dart';
import '../../repositories/chat_repository.dart';

class GetNumberOfMessageNotSeenUseCase extends StreamUseCase<int, String> {
  final ChatRepository _repository;

  GetNumberOfMessageNotSeenUseCase(this._repository);

  @override
  Stream<int> call(String parameters) =>
      _repository.getNumOfMessageNotSeen(parameters);
}
