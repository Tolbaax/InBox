import 'package:dartz/dartz.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/user_repository.dart';

class SetUserStateUseCase extends UseCase<void, bool> {
  final UserRepository _repository;

  SetUserStateUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(bool params) async {
    return await _repository.setUserState(params);
  }
}
