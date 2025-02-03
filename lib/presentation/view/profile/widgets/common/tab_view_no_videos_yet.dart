import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/app_colors.dart';

class TabViewNoVideosYet extends StatelessWidget {
  const TabViewNoVideosYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 65.0.h,
          width: 65.0.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.blackOlive),
          ),
          child: Icon(
            FontAwesomeIcons.video,
            size: 35.0.sp,
            color: AppColors.blackOlive,
          ),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        Text(
          'No Videos Yet',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17.0.sp,
          ),
        )
      ],
    );
  }
}
