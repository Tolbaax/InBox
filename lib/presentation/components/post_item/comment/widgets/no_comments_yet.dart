import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:inbox/core/utils/assets_manager.dart';
import 'package:rive/rive.dart';

class NoCommentsYet extends StatelessWidget {
  const NoCommentsYet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 140.0.h,
            child: const RiveAnimation.asset(
              ImgAssets.waiting,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            AppStrings.noComments,
            style: TextStyle(
              fontSize: 18.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          Text(
            AppStrings.betheFirst,
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20.0.h,
          ),
        ],
      ),
    );
  }
}
