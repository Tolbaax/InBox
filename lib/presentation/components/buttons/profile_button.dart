import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class ProfileButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final Color? color;

  const ProfileButton(
      {super.key, required this.onTap, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28.0.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.gray.withOpacity(0.28),
          borderRadius: BorderRadius.circular(9.0.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color == null ? AppColors.black : AppColors.white,
              fontSize: 13.4.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
