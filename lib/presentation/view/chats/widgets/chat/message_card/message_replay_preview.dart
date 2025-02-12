import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/params/chat/message_reply.dart';
import 'message_reply_card.dart';

class MessageReplayPreview extends HookWidget {
  final MessageReplay messageReplay;

  const MessageReplayPreview({super.key, required this.messageReplay});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 170),
    )..forward();

    final slideAnimation = useMemoized(
      () => Tween<Offset>(begin: const Offset(0, 0.8), end: Offset.zero)
          .animate(CurvedAnimation(
              parent: animationController, curve: Curves.easeOut)),
      [animationController],
    );

    final fadeAnimation = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut)),
      [animationController],
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
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
        ),
      ),
    );
  }
}
