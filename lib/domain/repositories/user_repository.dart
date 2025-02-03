import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/params/auth/user_params.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<String> getCurrentUID();

  Future<Either<Failure, void>> setUserState(bool isOnline);

  Future<Either<Failure, void>> updateUserData(UserParams params);

  Future<UserEntity> getUserById(String uID);

  Future<Either<Failure, void>> followUser(String followUserID);

  Future<Either<Failure, void>> unFollowUser(String followUserID);

  Future<Either<Failure, void>> deleteUserAccount();
}
