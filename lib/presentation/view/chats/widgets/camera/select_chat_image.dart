import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox/core/shared/common.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../config/routes/app_routes.dart';
import '../../../../../../../core/functions/navigator.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../core/functions/app_dialogs.dart';

class SelectChatImage extends StatelessWidget {
  final String receiverId;
  final String name;
  final bool isCamera;

  const SelectChatImage({
    super.key,
    required this.receiverId,
    required this.name,
    this.isCamera = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20.0.sp,
      icon: Icon(
        isCamera ? Icons.camera_alt : Icons.photo,
        color: AppColors.black.withOpacity(0.45),
        size: 22.0.sp,
      ),
      onPressed: () async {
        if (!await requestPermission(
            isCamera ? Permission.camera : Permission.storage)) {
          AppDialogs.showToast(msg: 'Storage permission denied');
          return;
        }

        if (context.mounted) {
          File? image = await pickImageFile(context,
              imageSource: isCamera ? ImageSource.camera : ImageSource.gallery);
          if (image != null) {
            if (context.mounted) {
              navigateTo(
                context,
                Routes.sendingImageViewRoute,
                arguments: {
                  'path': image.path,
                  'uId': receiverId,
                  'name': name,
                  'imageFile': image,
                },
              );
            }
          }
        }
      },
    );
  }
}
