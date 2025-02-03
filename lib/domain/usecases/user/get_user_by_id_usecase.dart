import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetUserByIdUseCase {
  final UserRepository _repository;

  GetUserByIdUseCase(this._repository);

  Future<UserEntity> call(String params) async {
    return await _repository.getUserById(params);
  }
}
