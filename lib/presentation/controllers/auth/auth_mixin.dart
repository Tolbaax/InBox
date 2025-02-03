import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_states.dart';

mixin AuthProviders on Cubit<AuthStates> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController1 = TextEditingController();
  final passwordController1 = TextEditingController();
  final confirmPassController = TextEditingController();
  final bioController = TextEditingController();
  IconData suffix = Icons.visibility_off_outlined;
  IconData suffix1 = Icons.visibility_off_outlined;
  IconData suffix2 = Icons.visibility_off_outlined;
  bool isPassword = true;
  bool isPassword1 = true;
  bool isPassword2 = true;

  changeVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeVisibilityState());
  }

  void changeVisibility1() {
    isPassword1 = !isPassword1;
    suffix1 =
    isPassword1 ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeVisibilityState1());
  }

  void changeVisibility2() {
    isPassword2 = !isPassword2;
    suffix2 =
    isPassword2 ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeVisibilityState2());
  }

  void clearSignInControllers() {
    emailController.clear();
    passwordController.clear();
    emit(ClearSignInControllersState());
  }

  void clearSignUpControllers() {
    userNameController.clear();
    nameController.clear();
    emailController1.clear();
    passwordController1.clear();
    confirmPassController.clear();
    emit(ClearSignUpControllerState());
  }
}
