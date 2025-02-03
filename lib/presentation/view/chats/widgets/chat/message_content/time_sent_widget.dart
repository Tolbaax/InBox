import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/time_extension.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../domain/entities/message_entity.dart';

class TimeSentWidget extends StatelessWidget {
  final MessageEntity message;
  final bool isText;
  final bool isMe;

  const TimeSentWidget({
    super.key,
    required this.message,
    required this.isMe,
    required this.isText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4, bottom: 4),
      child: Container(
        padding: isText
            ? EdgeInsets.zero
            : EdgeInsetsDirectional.symmetric(vertical: 0.0, horizontal: 4.0.w),
        decoration: BoxDecoration(
          color:
              isText ? Colors.transparent : AppColors.black.withOpacity(0.2.sp),
          borderRadius: BorderRadius.circular(12.0.sp),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.timeSent.amPmMode,
              style: TextStyle(
                fontSize: 11.0.sp,
                color: isText ? AppColors.grayRegular : AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.0.w),
            if (isMe)
              Icon(
                Icons.done_all_outlined,
                size: 16.0.sp,
                color: message.isSeen
                    ? AppColors.primary
                    : isText
                        ? AppColors.grayRegular
                        : AppColors.white,
              ),
          ],
        ),
      ),
    );
  }
}
