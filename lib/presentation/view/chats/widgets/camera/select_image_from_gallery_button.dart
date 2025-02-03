import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/shared/common.dart';

import '../../../../../../../config/routes/app_routes.dart';
import '../../../../../../../core/functions/navigator.dart';
import '../../../../../../../core/utils/app_colors.dart';

class SelectImageFromGalleryButton extends StatelessWidget {
  final String receiverId;
  final String name;

  const SelectImageFromGalleryButton(
      {super.key, required this.receiverId, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectImageFromGallery(context),
      child: CircleAvatar(
        radius: 22.0.sp,
        backgroundColor: Colors.black38,
        child: Icon(
          Icons.photo,
          color: AppColors.white,
          size: 25.0.sp,
        ),
      ),
    );
  }

  void selectImageFromGallery(BuildContext context) async {
    File? image = await pickImageFile(context);
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
}
