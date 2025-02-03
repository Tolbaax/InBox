import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';

class NoMessagesYet extends StatelessWidget {
  const NoMessagesYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.messageFriendsDirect,
            style: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 7.0.h,
          ),
          Text(
            AppStrings.sendPrivateMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
