import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/auth/signup_params.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/firebase_auth_repository.dart';

class SignUpUseCase implements UseCase<void, SignUpParams> {
  final FirebaseAuthRepository _repository;

  SignUpUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(SignUpParams params) async {
    return await _repository.signUp(params);
  }
}
