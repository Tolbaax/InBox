import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../components/profile_image/my_cached_net_image.dart';

class LoadingChatAppBar extends StatelessWidget {
  const LoadingChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.policeBlue,
      leading: BackButton(color: AppColors.white),
      leadingWidth: 38.0.w,
      titleSpacing: 0.0,
      toolbarHeight: kToolbarHeight + 8.0.h,
      title: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            MyCachedNetImage(
              imageUrl: '',
              radius: 19.0.sp,
            ),
            SizedBox(width: 8.0.w),
            Container(
              constraints: BoxConstraints(maxWidth: context.width * 0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: context.height * 0.012,
                    width: context.width * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.0.sp),
                    ),
                  ),
                  SizedBox(height: 6.5.h),
                  Container(
                    height: context.height * 0.005,
                    width: context.width * 0.35,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.0.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
