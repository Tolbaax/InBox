import 'package:equatable/equatable.dart';

import '../../../core/enums/message_type.dart';

class MessageEntity extends Equatable {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String message;
  final String messageId;
  final DateTime timeSent;
  final bool isSeen;
  final MessageType messageType;
  final String fileUrl;

  //Reply Message
  final String repliedMessage;
  final String repliedTo;
  final MessageType repliedMessageType;

  const MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageId,
    required this.timeSent,
    required this.isSeen,
    required this.messageType,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.senderName,
    required this.fileUrl,
  });

  @override
  List<Object?> get props => [
        senderId,
        receiverId,
        message,
        messageId,
        timeSent,
        isSeen,
        messageType,
        repliedMessage,
        repliedTo,
        repliedMessageType,
        senderName,
        fileUrl,
      ];
}
