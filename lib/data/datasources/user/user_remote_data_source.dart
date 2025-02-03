import '../../../../core/params/auth/user_params.dart';
import '../../../domain/entities/user_entity.dart';
import '../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();

  Future<String> getCurrentUID();

  Future<void> setUserState(bool isOnline);

  Future<void> updateUserData(UserParams params);

  Future<UserEntity> getUserById(String uId);

  Future<void> followUser(String followUserID);

  Future<void> unFollowUser(String followUserID);

  Future<void> deleteUserAccount();
}
