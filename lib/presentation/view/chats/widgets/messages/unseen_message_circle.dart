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
      padding: EdgeInsetsDirectional.only(top: context.height * 0.037),
      child: Badge.count(
        count: unseenMessageCount,
        padding: const EdgeInsets.all(3),
        textStyle: TextStyle(fontSize: 12.sp),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
