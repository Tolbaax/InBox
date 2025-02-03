import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';

class PlayIcon extends StatelessWidget {
  const PlayIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: AppColors.white)),
      child: Icon(
        Icons.play_arrow,
        shadows: [
          BoxShadow(
            color: AppColors.blackOlive.withOpacity(0.8),
            blurRadius: 5.0.sp,
            spreadRadius: 5.0.sp,
            offset: const Offset(2, 2),
          ),
        ],
        size: 45.0.sp,
        color: AppColors.white,
      ),
    );
  }
}
