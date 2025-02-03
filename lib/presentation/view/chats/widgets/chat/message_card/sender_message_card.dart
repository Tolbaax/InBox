import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/params/chat/message_reply.dart';
import 'package:inbox/domain/entities/message_entity.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import 'package:swipe_to/swipe_to.dart';

import '../message_content/message_content.dart';
import 'first_message_small_curved_bubble.dart';
import 'message_reply_card.dart';

class SenderMessageCard extends StatelessWidget {
  final MessageEntity message;
  final MessageEntity lastMessage;
  final bool isFirst;

  const SenderMessageCard({
    super.key,
    required this.message,
    required this.isFirst,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    final bool isReplying = message.repliedMessage.isNotEmpty;

    return Column(
      children: [
        SwipeTo(
          onLeftSwipe: (dragUpdateDetails) {
            ChatCubit.get(context).onMessageReply(
              MessageReplay(
                message: message.message,
                isMe: false,
                messageType: message.messageType,
                repliedTo: message.senderName,
              ),
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: isFirst ? 10.0.sp : 2.5.sp,
                left: isFirst ? 8.0.sp : 15.0.sp,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (isFirst) const FirstMessageSmallCurvedBubble(isMe: false),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: context.width * 0.8),
                    child: Card(
                      elevation: isFirst ? 0.0 : 1.0.sp,
                      margin: const EdgeInsets.all(0),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(10),
                          bottomLeft: const Radius.circular(10),
                          bottomRight: const Radius.circular(10),
                          topLeft:
                              isFirst ? Radius.zero : const Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (isReplying)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: MessageReplyCard(
                                text: message.repliedMessage,
                                repliedMessageType: message.repliedMessageType,
                                isMe: message.repliedTo != message.senderName,
                                repliedTo: message.repliedTo,
                              ),
                            ),
                          MessageContent(message: message, isMe: false),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (message == lastMessage) SizedBox(height: context.height * 0.012),
      ],
    );
  }
}
