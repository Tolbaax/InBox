import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../enums/message_type.dart';
import 'message_reply.dart';

class MessageParams extends Equatable {
  final String message;
  final String receiverId;
  final MessageReplay? messageReplay;
  final MessageType? messageType;
  final File? messageFile;

  const MessageParams({
    required this.message,
    required this.receiverId,
    this.messageReplay,
    this.messageType,
    this.messageFile,
  });

  @override
  List<Object?> get props => [
        message,
        receiverId,
        messageReplay,
        messageType,
        messageFile,
      ];
}
