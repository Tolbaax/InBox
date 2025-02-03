import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String text;
  final bool? condition;
  final List<Color>? colors;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.condition = false,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0.h,
        width: context.width * 0.8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors ??
                [
                  AppColors.primary,
                  AppColors.primary,
                  AppColors.lightBlue,
                ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20.0.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.5),
              blurRadius: 3.0.sp,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: condition!
              ? CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5.sp,
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
