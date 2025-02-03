import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';

class SettingsOption extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData icon;
  final String title;
  final Color? titleColor, leadingColor, trailingColor;
  final double? bottom;

  const SettingsOption({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    this.titleColor,
    this.leadingColor,
    this.trailingColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: bottom ?? 20.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.flashWhite.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10.0.sp),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.flashWhite.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(20.0.sp),
          ),
          onTap: onTap,
          leading: Icon(
            icon,
            size: 19.0.sp,
            color: leadingColor ?? AppColors.black.withOpacity(0.5),
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15.2.sp,
                fontWeight: FontWeight.w500,
                color: titleColor ?? AppColors.black.withOpacity(0.8)),
          ),
          trailing: Icon(
            CupertinoIcons.forward,
            color: trailingColor ?? AppColors.black.withOpacity(0.5),
            size: 19.0.sp,
          ),
        ),
      ),
    );
  }
}
