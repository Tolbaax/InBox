import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/user_repository.dart';

class UnFollowUserUseCase implements UseCase<void, String> {
  final UserRepository _repository;

  UnFollowUserUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _repository.unFollowUser(params);
  }
}
