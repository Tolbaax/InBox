import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/auth/user_params.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/user_repository.dart';

class UpdateUserDataUseCase implements UseCase<void, UserParams> {
  final UserRepository _repository;

  UpdateUserDataUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(UserParams params) async {
    return await _repository.updateUserData(params);
  }
}
