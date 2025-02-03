import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';

class PostActionIcon extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData icon;
  final String text;
  final Color? iconColor;

  const PostActionIcon({
    super.key,
    this.onTap,
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.5.sp,
            color: iconColor ?? AppColors.grayRegular,
          ),
          SizedBox(
            width: 4.0.w,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.8.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
