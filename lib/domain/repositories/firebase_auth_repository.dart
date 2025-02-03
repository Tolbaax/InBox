import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/params/auth/signup_params.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, void>> signIn(SignInParams params);

  Future<Either<Failure, void>> signUp(SignUpParams params);

  Future<Either<Failure, void>> signOut();
}
