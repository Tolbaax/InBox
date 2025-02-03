import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/shared/common.dart';
import 'package:inbox/core/utils/app_colors.dart';

class StatisticsColumn extends StatelessWidget {
  final int number;
  final String text;

  const StatisticsColumn({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.width * 0.125),
          child: Text(
            formatNumber(number),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 3.5.h,
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.blackOlive.withOpacity(0.8),
            fontSize: 12.1.sp,
          ),
        ),
      ],
    );
  }
}
