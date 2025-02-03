import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/domain/entities/post_entity.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/shared/common.dart';
import '../../../../../core/utils/app_colors.dart';

class PostItemText extends StatelessWidget {
  final PostEntity post;

  const PostItemText({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.0.h),
      child: Align(
        alignment: isArabic(post.postText)
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: ReadMoreText(
          post.postText,
          trimLines: 12,
          trimMode: TrimMode.Line,
          moreStyle: TextStyle(fontSize: 12.0.sp, color: AppColors.primary),
          lessStyle: TextStyle(fontSize: 12.0.sp, color: AppColors.primary),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.5.sp,
            wordSpacing: 1.2.sp,
          ),
        ),
      ),
    );
  }
}
