import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../components/profile_image/my_cached_net_image.dart';

class LoadingChatAppBar extends StatelessWidget {
  const LoadingChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.policeBlue,
      child: Row(
        children: [
          MyCachedNetImage(
            imageUrl: '',
            radius: 19.sp,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerBox(context.width * 0.25, context.height * 0.012),
              SizedBox(height: 6.5.h),
              _buildShimmerBox(context.width * 0.35, context.height * 0.005),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5.sp),
      ),
    );
  }
}
