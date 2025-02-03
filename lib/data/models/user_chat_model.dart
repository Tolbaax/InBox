import '../../domain/entities/user_chat_entity.dart';

class UserChatModel extends UserChatEntity {
  const UserChatModel({
    required super.name,
    required super.profilePic,
    required super.userId,
    required super.lastMessageSenderId,
    required super.lastMessage,
    required super.isSeen,
    required super.timeSent,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'profilePic': profilePic,
        'userId': userId,
        'lastMessageSenderId': lastMessageSenderId,
        'lastMessage': lastMessage,
        'isSeen': isSeen,
        'timeSent': timeSent.millisecondsSinceEpoch,
      };

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
        name: json['name'],
        profilePic: json['profilePic'],
        userId: json['userId'],
        lastMessageSenderId: json['lastMessageSenderId'],
        lastMessage: json['lastMessage'],
        isSeen: json['isSeen'],
        timeSent: DateTime.fromMillisecondsSinceEpoch(json['timeSent']),
      );
}
