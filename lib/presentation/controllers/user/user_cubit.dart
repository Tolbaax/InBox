import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/params/auth/user_params.dart';
import 'package:inbox/core/usecase/usecase.dart';
import 'package:inbox/domain/entities/user_entity.dart';
import 'package:inbox/domain/usecases/user/delete_user_account.dart';
import 'package:inbox/domain/usecases/user/follow_user_use_case.dart';
import 'package:inbox/domain/usecases/user/get_current_user_usecase.dart';
import 'package:inbox/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:inbox/domain/usecases/user/set_user_state_usecase.dart';
import 'package:inbox/domain/usecases/user/unfollow_user_use_case.dart';
import 'package:inbox/domain/usecases/user/update_user_data.dart';
import 'package:inbox/presentation/controllers/user/user_mixin.dart';
import 'package:inbox/presentation/controllers/user/user_states.dart';
import '../../../../../../core/error/failure.dart';

class UserCubit extends Cubit<UserStates> with UserMixin {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SetUserStateUseCase _setUserStateUseCase;
  final UpdateUserDataUseCase _updateUserDataUseCase;
  final FollowUserUseCase _followUserUseCase;
  final UnFollowUserUseCase _unFollowUserUseCase;
  final GetUserByIdUseCase _getUserByIdUseCase;
  final DeleteUserAccountUseCase _deleteUserAccountUseCase;

  UserCubit(
    this._getCurrentUserUseCase,
    this._setUserStateUseCase,
    this._updateUserDataUseCase,
    this._followUserUseCase,
    this._unFollowUserUseCase,
    this._getUserByIdUseCase,
    this._deleteUserAccountUseCase,
  ) : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  UserEntity? userEntity;

  Future<void> getCurrentUser() async {
    emit(GetCurrentUserLoadingState());
    final result = await _getCurrentUserUseCase(NoParams());

    result.fold(
      (l) => emit(GetCurrentUserErrorState()),
      (r) {
        userEntity = r;
        emit(GetCurrentUserSuccessState());
      },
    );
  }

  Future<UserEntity> getUserById(String uID) async {
    emit(GetUserByIDLoadingState());
    final user = await _getUserByIdUseCase.call(uID);
    emit(GetUserByIDSuccessState());
    return user;
  }

  Future<void> setUserState({required bool isOnline}) async {
    final result = await _setUserStateUseCase(isOnline).catchError((e) {
      if (e is FirebaseAuthException) {
        AppDialogs.showToast(msg: e.message.toString());
        return Left(ServerFailure(e.message.toString()));
      }
      return const Left(ServerFailure("An error occurred"));
    });

    result.fold(
      (l) => emit(SetUserStateErrorState()),
      (r) => emit(SetUserStateSuccessState()),
    );
  }

  Future<void> updateUserData(UserParams params) async {
    emit(UpdateUserDataLoadingState());
    final result = await _updateUserDataUseCase(
      UserParams(
        username: params.username.trim().toLowerCase(),
        name: params.name.trim(),
        bio: params.bio.trim(),
        profileUrl: params.profileUrl,
      ),
    ).catchError((e) {
      if (e is FirebaseAuthException) {
        AppDialogs.showToast(msg: e.message.toString());
        return Left(ServerFailure(e.message.toString()));
      }
      return Left(ServerFailure(e.message.toString()));
    });
    result.fold(
      (l) => emit(UpdateUserDataErrorState()),
      (r) => emit(UpdateUserDataSuccessState()),
    );
  }

  Future<void> followUser(String followUserID) async {
    emit(FollowUserLoadingState());
    final result = await _followUserUseCase(followUserID);

    result.fold(
      (l) => emit(FollowUserErrorState()),
      (r) => emit(FollowUserSuccessState()),
    );
  }

  Future<void> unFollowUser(String followUserID) async {
    emit(UnFollowUserLoadingState());
    final result = await _unFollowUserUseCase(followUserID);

    result.fold(
      (l) => emit(UnFollowUserErrorState()),
      (r) => emit(UnFollowUserSuccessState()),
    );
  }

  Future<void> deleteUserAccount() async {
    emit(DeleteUserAccountLoadingState());

    final result = await _deleteUserAccountUseCase();

    result.fold(
      (l) => emit(DeleteUserAccountErrorState()),
      (r) => emit(DeleteUserAccountSuccessState()),
    );
  }
}
