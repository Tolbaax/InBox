import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/enums/message_type.dart';
import '../../../../../../../core/utils/app_colors.dart';

class ReplayMessageContent extends StatelessWidget {
  final MessageType repliedMessageType;
  final String text;

  const ReplayMessageContent(
      {super.key, required this.repliedMessageType, required this.text});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: AppColors.black.withOpacity(0.65),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    switch (repliedMessageType) {
      case MessageType.text:
        return Text(
          text,
          style: textStyle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
      case MessageType.image:
        return Row(
          children: [
            Icon(Icons.image,
                color: AppColors.black.withOpacity(0.6), size: 16.0.sp),
            const SizedBox(width: 4),
            Text(
              'Photo',
              style: textStyle,
            ),
          ],
        );
      case MessageType.gif:
        return Row(
          children: [
            Icon(Icons.gif_box_sharp,
                color: AppColors.black.withOpacity(0.6), size: 16.0.sp),
            const SizedBox(width: 4),
            Text(
              'GIF',
              style: textStyle,
            ),
          ],
        );
      case MessageType.video:
        return Row(
          children: [
            Icon(Icons.videocam,
                color: AppColors.black.withOpacity(0.6), size: 16.0.sp),
            const SizedBox(width: 4),
            Text(
              'Video',
              style: textStyle,
            ),
          ],
        );
      case MessageType.audio:
        return Row(
          children: [
            Icon(Icons.mic,
                color: AppColors.black.withOpacity(0.6), size: 16.0.sp),
            const SizedBox(width: 4),
            Text(
              'Voice message',
              style: textStyle,
            ),
          ],
        );
      default:
        return Text(text, maxLines: 3, overflow: TextOverflow.ellipsis);
    }
  }
}
