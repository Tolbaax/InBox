import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:rive/rive.dart';

import '../../../../../core/utils/assets_manager.dart';

class NoPotsYet extends StatelessWidget {
  const NoPotsYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.welcome,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21.0.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Text(
              AppStrings.followPeople,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5.sp,
                color: AppColors.blackOlive.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 100.0.h,
              child: const RiveAnimation.asset(
                ImgAssets.waiting,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
