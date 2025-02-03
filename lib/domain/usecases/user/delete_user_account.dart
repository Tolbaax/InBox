import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';

import '../../repositories/user_repository.dart';

class DeleteUserAccountUseCase {
  final UserRepository _repository;

  DeleteUserAccountUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.deleteUserAccount();
  }
}
