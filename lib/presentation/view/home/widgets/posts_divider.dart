import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';

class PostsDivider extends StatelessWidget {
  const PostsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.0.h,
      child: Divider(
        thickness: 5.0.sp,
        color: AppColors.gray.withOpacity(0.3),
      ),
    );
  }
}
