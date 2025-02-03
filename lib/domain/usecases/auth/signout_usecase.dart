import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/firebase_auth_repository.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final FirebaseAuthRepository _repository;

  SignOutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.signOut();
  }
}
