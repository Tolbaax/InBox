import '../../repositories/user_repository.dart';

class GetCurrentUIDUseCase {
  final UserRepository _repository;

  GetCurrentUIDUseCase(this._repository);

  Future<String> call() async {
    return await _repository.getCurrentUID();
  }
}
