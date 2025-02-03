import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/params/chat/message_reply.dart';
import 'message_reply_card.dart';

class MessageReplayPreview extends StatelessWidget {
  final MessageReplay messageReplay;

  const MessageReplayPreview({super.key, required this.messageReplay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsetsDirectional.only(start: 7.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.0.sp),
          topLeft: Radius.circular(12.0.sp),
        ),
        border: Border.all(color: Colors.white, width: 0.0),
      ),
      child: MessageReplyCard(
        showCloseButton: true,
        isMe: messageReplay.isMe,
        text: messageReplay.message,
        repliedMessageType: messageReplay.messageType,
        repliedTo: messageReplay.repliedTo,
      ),
    );
  }
}
