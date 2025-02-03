import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/usecase/usecase.dart';
import 'package:inbox/domain/repositories/firebase_auth_repository.dart';

class SignInUseCase implements UseCase<void, SignInParams> {
  final FirebaseAuthRepository _repository;

  SignInUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(SignInParams params) async {
    return await _repository.signIn(params);
  }
}
