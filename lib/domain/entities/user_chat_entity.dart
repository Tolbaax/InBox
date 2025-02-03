import 'package:equatable/equatable.dart';

class UserChatEntity extends Equatable {
  final String name;
  final String profilePic;
  final String userId;
  final String lastMessageSenderId;
  final String lastMessage;
  final bool isSeen;
  final DateTime timeSent;

  const UserChatEntity({
    required this.name,
    required this.profilePic,
    required this.userId,
    required this.lastMessageSenderId,
    required this.lastMessage,
    required this.isSeen,
    required this.timeSent,
  });

  @override
  List<Object?> get props => [
        name,
        profilePic,
        userId,
        lastMessageSenderId,
        lastMessage,
        isSeen,
        timeSent,
      ];
}
