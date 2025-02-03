import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/params/chat/message_reply.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:inbox/domain/entities/message_entity.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import 'package:inbox/presentation/view/chats/widgets/chat/message_card/first_message_small_curved_bubble.dart';
import 'package:inbox/presentation/view/chats/widgets/chat/message_card/message_reply_card.dart';
import 'package:inbox/presentation/view/chats/widgets/chat/message_content/message_content.dart';
import 'package:swipe_to/swipe_to.dart';

class MyMessageCard extends StatelessWidget {
  final MessageEntity message;
  final MessageEntity lastMessage;
  final bool isFirst;

  const MyMessageCard({
    super.key,
    required this.message,
    required this.lastMessage,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = message.repliedMessage.isNotEmpty;

    return Column(
      children: [
        SwipeTo(
          onRightSwipe: (dragUpdateDetails) {
            ChatCubit.get(context).onMessageReply(
              MessageReplay(
                message: message.message,
                isMe: true,
                messageType: message.messageType,
                repliedTo: message.senderName,
              ),
            );
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                  top: isFirst ? 8.0.sp : 2.5.sp,
                  right: isFirst ? 8.sp : 15.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: context.width * 0.8),
                    child: Card(
                      elevation: 1.0.sp,
                      margin: const EdgeInsets.all(0.0),
                      color: AppColors.water,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0.sp),
                          bottomLeft: Radius.circular(10.0.sp),
                          bottomRight: Radius.circular(10.0.sp),
                          topRight:
                              isFirst ? Radius.zero : Radius.circular(10.0.sp),
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
                                isMe: message.repliedTo == message.senderName,
                                repliedTo: message.repliedTo,
                              ),
                            ),
                          MessageContent(message: message, isMe: true),
                        ],
                      ),
                    ),
                  ),
                  if (isFirst) const FirstMessageSmallCurvedBubble(isMe: true),
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
