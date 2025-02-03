import 'package:flutter/material.dart';
import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/domain/entities/message_entity.dart';

import 'video_message.dart';
import 'image_message.dart';
import 'text_message.dart';

class MessageContent extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;

  const MessageContent({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    switch (message.messageType) {
      case MessageType.text:
        return TextMessage(message: message, isMe: isMe);
      case MessageType.gif:
        return ImageMessage(message: message, isMe: isMe);
      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ImageMessage(message: message, isMe: isMe),
            if (message.fileUrl.isNotEmpty && message.message.isNotEmpty)
              TextMessage(message: message, isMe: isMe),
          ],
        );
      case MessageType.video:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VideoMessage(message: message, isMe: isMe),
            if (message.fileUrl.isNotEmpty && message.message.isNotEmpty)
              TextMessage(message: message, isMe: isMe),
          ],
        );
      default:
        return TextMessage(message: message, isMe: isMe);
    }
  }
}
