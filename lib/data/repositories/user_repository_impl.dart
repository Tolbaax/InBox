import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/domain/repositories/user_repository.dart';

import '../../../core/params/auth/user_params.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/user/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<String> getCurrentUID() async =>
      await userRemoteDataSource.getCurrentUID();

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    final result = await userRemoteDataSource.getCurrentUser();
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> setUserState(bool isOnline) async {
    final result = await userRemoteDataSource.setUserState(isOnline);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData(UserParams params) async {
    final result = await userRemoteDataSource.updateUserData(params);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<UserEntity> getUserById(String uID) =>
      userRemoteDataSource.getUserById(uID);

  @override
  Future<Either<Failure, void>> followUser(String followUserID) async {
    final result = await userRemoteDataSource.followUser(followUserID);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> unFollowUser(String followUserID) async {
    final result = await userRemoteDataSource.unFollowUser(followUserID);

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserAccount() async {
    final result = await userRemoteDataSource.deleteUserAccount();

    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }
}
