import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';

import '../../../../../../../core/enums/message_type.dart';
import '../../../../../controllers/chat/chat_cubit.dart';
import 'reply_message_content.dart';

class MessageReplyCard extends StatelessWidget {
  final bool showCloseButton;
  final MessageType repliedMessageType;
  final String text;
  final bool isMe;
  final String repliedTo;

  const MessageReplyCard({
    super.key,
    this.showCloseButton = false,
    required this.repliedMessageType,
    required this.text,
    required this.isMe,
    required this.repliedTo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width * 0.8),
        padding: EdgeInsets.only(
            left: 9.0.sp, right: 5.0.sp, top: 4.5.sp, bottom: 7.5.sp),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.03),
          border: Border(
            left: BorderSide(
              color: isMe ? AppColors.primary : AppColors.amethyst,
              width: 4.0.sp,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: context.width * 0.78),
                  child: Text(
                    isMe ? 'You' : repliedTo,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.1.sp,
                      color: isMe
                          ? AppColors.primary.withOpacity(0.8)
                          : AppColors.amethyst,
                    ),
                  ),
                ),
                if (showCloseButton)
                  GestureDetector(
                    onTap: () {
                      ChatCubit.get(context).cancelReply();
                    },
                    child: Icon(
                      Icons.close,
                      size: 16.0.sp,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            ReplayMessageContent(
              repliedMessageType: repliedMessageType,
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}
