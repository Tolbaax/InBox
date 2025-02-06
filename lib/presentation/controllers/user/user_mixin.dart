import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/common.dart';
import '../../../../core/utils/app_strings.dart';
import 'user_states.dart';

mixin UserMixin on Cubit<UserStates> {
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final bioController = TextEditingController();

  File? profileImageFile;

  void selectProfileImageFromGallery(BuildContext context) async {
    final pickedFile = await pickImageFile(context);
    if (pickedFile != null) {
      cropImage(pickedFile.path,
              title: AppStrings.profileImage, isProfile: true)
          .then((value) {
        if (value != null) {
          profileImageFile = File(value.path);
          emit(SelectProfileImageFromGalleryState());
        }
      });
    }
  }

  void disposeProfileImage() {
    deleteFile(profileImageFile);
    profileImageFile = null;
  }
}
