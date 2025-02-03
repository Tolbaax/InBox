import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class EditButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const EditButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.5.sp,
        width: 30.5.sp,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              offset: const Offset(1, 2),
              blurRadius: 1.5.sp,
            ),
          ],
        ),
        child: Icon(
          Icons.camera_alt_rounded,
          color: AppColors.white,
          size: 18.0.sp,
        ),
      ),
    );
  }
}
