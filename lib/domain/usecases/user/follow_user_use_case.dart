import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/user_repository.dart';

class FollowUserUseCase implements UseCase<void, String> {
  final UserRepository _repository;

  FollowUserUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _repository.followUser(params);
  }
}
