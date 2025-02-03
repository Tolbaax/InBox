import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.message,
    required super.messageId,
    required super.timeSent,
    required super.isSeen,
    required super.messageType,
    required super.repliedMessage,
    required super.repliedTo,
    required super.repliedMessageType,
    required super.senderName,
    required super.fileUrl,
  });

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'messageId': messageId,
        'timeSent': timeSent.millisecondsSinceEpoch,
        'isSeen': isSeen,
        'messageType': messageType.type,
        'repliedMessage': repliedMessage,
        'repliedTo': repliedTo,
        'repliedMessageType': repliedMessageType.type,
        'senderName': senderName,
        'fileUrl': fileUrl,
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        message: json['message'],
        messageId: json['messageId'],
        timeSent: DateTime.fromMillisecondsSinceEpoch(json['timeSent']),
        isSeen: json['isSeen'],
        messageType: (json['messageType'] as String).toEnum(),
        repliedMessage: json['repliedMessage'],
        repliedTo: json['repliedTo'],
        repliedMessageType: (json['repliedMessageType'] as String).toEnum(),
        senderName: json['senderName'],
        fileUrl: json['fileUrl'],
      );
}
