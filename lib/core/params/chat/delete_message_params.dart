import 'package:equatable/equatable.dart';

class DeleteMessageParams extends Equatable {
  final String receiverId;
  final List<String> messageIds;
  final bool isMyMessages;
  final bool deleteForMeWithEveryOne;

  const DeleteMessageParams({
    required this.receiverId,
    required this.messageIds,
    this.isMyMessages = false,
    this.deleteForMeWithEveryOne = false,
  });

  @override
  List<Object?> get props => [
        receiverId,
        messageIds,
        isMyMessages,
        deleteForMeWithEveryOne,
      ];
}
