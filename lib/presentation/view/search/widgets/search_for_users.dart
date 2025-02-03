import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:rive/rive.dart';

import '../../../../../core/utils/assets_manager.dart';

class SearchForUsers extends StatelessWidget {
  const SearchForUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 85.0.h,
            child: const RiveAnimation.asset(
              ImgAssets.search,
            ),
          ),
          SizedBox(
            height: 25.0.h,
          ),
          Text(
            AppStrings.searchForUsers,
            style: TextStyle(
                fontSize: 18.5.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5.sp),
          )
        ],
      ),
    );
  }
}
