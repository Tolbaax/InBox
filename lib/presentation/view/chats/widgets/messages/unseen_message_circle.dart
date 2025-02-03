import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../../../../core/utils/app_colors.dart';

class UnseenMessagesCircle extends StatelessWidget {
  final int unseenMessageCount;

  const UnseenMessagesCircle({super.key, required this.unseenMessageCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: context.height * 0.035,
      ),
      child: CircleAvatar(
        radius: 10.0.sp,
        backgroundColor: AppColors.primary.withOpacity(0.9),
        child: Center(
          child: Text(
            unseenMessageCount >= 99 ? '99+' : unseenMessageCount.toString(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 11.2.sp,
              fontWeight: FontWeight.w600,
              fontFamily: '',
            ),
          ),
        ),
      ),
    );
  }
}
