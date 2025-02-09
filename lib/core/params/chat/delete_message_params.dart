import 'package:equatable/equatable.dart';

class DeleteMessageParams extends Equatable {
  final String receiverId;
  final List<String> messageIds;

  const DeleteMessageParams({
    required this.receiverId,
    required this.messageIds,
  });

  @override
  List<Object?> get props => [
        receiverId,
        messageIds,
      ];
}
