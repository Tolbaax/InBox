import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/params/auth/signup_params.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../../domain/usecases/auth/signin_usecase.dart';
import '../../../domain/usecases/auth/signout_usecase.dart';
import '../../../domain/usecases/auth/signup_usecase.dart';
import 'auth_mixin.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> with AuthProviders {
  final SignOutUseCase _signOutUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;

  AuthCubit(
    this._signOutUseCase,
    this._signInUseCase,
    this._signUpUseCase,
  ) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> login() async {
    emit(LoginLoadingState());
    final result = await _signInUseCase(
      SignInParams(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    ).catchError((e) {
      if (e is FirebaseAuthException) {
        AppDialogs.showToast(msg: e.message.toString());
        return Left(ServerFailure(e.message.toString()));
      }
      return Left(ServerFailure(e.message.toString()));
    });
    result.fold(
      (l) => emit(LoginErrorState()),
      (r) => emit(LoginSuccessfullyState()),
    );
  }

  Future<void> register() async {
    emit(RegisterLoadingState());
    final result = await _signUpUseCase(
      SignUpParams(
        username: userNameController.text.trim().toLowerCase(),
        name: nameController.text.trim(),
        email: emailController1.text.trim(),
        password: passwordController1.text.trim(),
      ),
    ).catchError((e) {
      if (e is FirebaseAuthException) {
        AppDialogs.showToast(msg: e.message.toString());
        return Left(ServerFailure(e.message.toString()));
      }
      return Left(ServerFailure(e.message.toString()));
    });

    result.fold(
      (l) => emit(RegisterErrorState()),
      (r) => emit(RegisterSuccessfullyState()),
    );
  }

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    final result = await _signOutUseCase(NoParams()).catchError((e) {
      if (e is FirebaseAuthException) {
        AppDialogs.showToast(msg: e.message.toString());
        return Left(ServerFailure(e.message.toString()));
      }
      return Left(ServerFailure(e.message.toString()));
    });
    result.fold(
      (l) => emit(SignOutErrorState()),
      (r) => emit(SignOutSuccessState()),
    );
  }
}
