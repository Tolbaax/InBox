import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/time_extension.dart';

import '../../../../../../../core/utils/app_colors.dart';

class ChatTimeCard extends StatelessWidget {
  final DateTime dateTime;

  const ChatTimeCard({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        margin: EdgeInsets.all(5.0.sp),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.flashWhite,
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
        child: Text(
          dateTime.chatDayTime,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 11.5.sp,
          ),
        ),
      ),
    );
  }
}
