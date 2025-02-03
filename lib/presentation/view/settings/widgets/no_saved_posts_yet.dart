import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../../../../../core/utils/app_colors.dart';

class NoSavedPostsYet extends StatelessWidget {
  const NoSavedPostsYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: context.height * 0.14,
            width: context.height * 0.14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.black, width: 2.0.sp),
            ),
            child: Icon(
              FontAwesomeIcons.bookmark,
              size: 50.0.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: 12.0.h,
          ),
          Text(
            AppStrings.startSaving,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 19.0.sp,
            ),
          ),
          SizedBox(
            height: 8.0.h,
          ),
          Text(
            AppStrings.startSavingBio,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: context.height * 0.1,
          ),
        ],
      ),
    );
  }
}
