import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _repository.getCurrentUser();
  }
}
