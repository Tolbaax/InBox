import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/params/auth/signup_params.dart';
import '../../domain/repositories/firebase_auth_repository.dart';
import '../datasources/auth/local/auth_local_data_source.dart';
import '../datasources/auth/remote/firebase_remote_auth_data_source.dart';
import '../datasources/user/user_remote_data_source.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseRemoteAuthDataSource authDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final AuthLocalDataSource localDataSource;

  FirebaseAuthRepositoryImpl({
    required this.authDataSource,
    required this.userRemoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> signIn(SignInParams params) async {
    final result = await authDataSource.signIn(params);
    await localDataSource
        .setUserLoggedIn(await userRemoteDataSource.getCurrentUID());
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(SignUpParams params) async {
    final result = await authDataSource.signUp(params);

    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final result = await authDataSource.signOut();
    await localDataSource.removeUser();

    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }
}
