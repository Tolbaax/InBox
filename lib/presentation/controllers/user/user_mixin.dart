import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/shared/common.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../core/functions/app_dialogs.dart';
import 'user_states.dart';

mixin UserMixin on Cubit<UserStates> {
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final bioController = TextEditingController();

  File? profileImageFile;

  void selectProfileImageFromGallery(BuildContext context) async {
    if (!await requestPermission(Permission.storage)) {
      AppDialogs.showToast(msg: 'Storage permission denied');
      return;
    }

    if (context.mounted) {
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
  }

  void disposeProfileImage() {
    deleteFile(profileImageFile);
    profileImageFile = null;
  }
}
