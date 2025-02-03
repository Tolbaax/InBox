import 'package:equatable/equatable.dart';

class SetChatMessageSeenParams extends Equatable {
  final String receiverId;
  final String messageId;

  const SetChatMessageSeenParams(
      {required this.receiverId, required this.messageId});

  @override
  List<Object?> get props => [
        receiverId,
        messageId,
      ];
}
