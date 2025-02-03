import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/functions/navigator.dart';
import '../../../../../../core/utils/app_colors.dart';

class VideoViewTopRowWidget extends StatelessWidget {
  const VideoViewTopRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 4.0.w),
      child: Row(
        children: [
          IconButton(
            splashRadius: 20,
            iconSize: 25.0.sp,
            onPressed: () => navigatePop(context),
            icon: CircleAvatar(
              backgroundColor: AppColors.black.withOpacity(0.5),
              child: Icon(Icons.clear, color: AppColors.white),
            ),
          ),
          const Spacer(),
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            splashColor: Colors.black38,
            icon: const Icon(
              Icons.edit,
              size: 27,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
