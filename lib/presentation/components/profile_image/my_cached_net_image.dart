import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inbox/core/utils/assets_manager.dart';
import '../../../../core/utils/app_colors.dart';
import '../buttons/edit_button.dart';

class MyCachedNetImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final bool haveButton;
  final GestureTapCallback? onTap;
  final File? imageFile;

  const MyCachedNetImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.haveButton = false,
    this.onTap,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: radius.sp + 0.5.sp,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: ClipOval(
            child: imageFile != null
                ? Image.file(
                    imageFile!,
                    height: radius.sp * 2,
                    width: radius.sp * 2,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: radius.sp * 2,
                    width: radius.sp * 2,
                    placeholder: (context, url) => _buildPlaceholderWidget(),
                    errorWidget: (context, url, error) =>
                        Image.asset(ImgAssets.defaultProfilePic),
                    fit: BoxFit.cover,
                    fadeOutDuration: const Duration(seconds: 1),
                    fadeInDuration: const Duration(seconds: 2),
                  ),
          ),
        ),
        if (haveButton)
          Positioned(
            bottom: 2.8.sp,
            right: 2.8.sp,
            child: EditButton(onTap: onTap),
          ),
      ],
    );
  }

  Widget _buildPlaceholderWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: radius.sp * 2,
          width: radius.sp * 2,
          decoration: BoxDecoration(
            color: AppColors.grayRegular.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        ),
        SpinKitPulse(color: AppColors.primary),
      ],
    );
  }
}
