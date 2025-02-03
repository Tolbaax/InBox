import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:rive/rive.dart';

import '../../../../../core/utils/assets_manager.dart';

class NoUsersFound extends StatelessWidget {
  const NoUsersFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.0.h,
            child: const RiveAnimation.asset(
              ImgAssets.waiting,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 25.0.h,
          ),
          Text(
            AppStrings.noUsersFound,
            style: TextStyle(
              fontSize: 18.5.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
