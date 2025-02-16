import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/extensions/time_extension.dart';
import 'package:inbox/core/params/chat/set_chat_message_seen_params.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:inbox/domain/entities/message_entity.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import 'package:inbox/presentation/controllers/chat/chat_states.dart';

import '../../../../../../../core/functions/date_convertor.dart';
import '../../../../../../core/injection/injector.dart';
import '../message_card/chat_time_card.dart';
import '../message_card/my_message_card.dart';
import '../message_card/sender_message_card.dart';

class ChatMessagesList extends StatefulWidget {
  final String receiverId;

  const ChatMessagesList({super.key, required this.receiverId});

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  final ScrollController _scrollController = ScrollController();
  int _previousMessageCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (BuildContext context, ChatStates state) async {
        if (state is DeleteMessageSuccessState ||
            state is SendMessageSuccessState) {
          await sl<ChatCubit>().removeSelected();
          sl<ChatCubit>().isReplying = false;
        }
      },
      builder: (context, state) {
        final cubit  = context.read<ChatCubit>();
        return StreamBuilder<List<MessageEntity>>(
          stream: cubit.getChatMessages(widget.receiverId),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox.shrink();
            }

            final messages = snapshot.data!;
            final currentMessageCount = messages.length;

            // Scroll to the bottom when new messages arrive
            if (currentMessageCount > _previousMessageCount) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });
              _previousMessageCount = currentMessageCount;
            }

            return Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final lastMessage = messages.last;
                  final previousMessage =
                      index > 0 ? messages[index - 1] : null;

                  // Check if the current message should have a small bubble
                  final isFirst = index == 0 ||
                      message.senderId != previousMessage?.senderId ||
                      !message.timeSent.isSameDay(previousMessage!.timeSent);

                  // Set chat message seen
                  if (!message.isSeen &&
                      message.receiverId != widget.receiverId) {
                    cubit.setChatMessageSeen(
                      SetChatMessageSeenParams(
                        receiverId: widget.receiverId,
                        messageId: message.messageId,
                      ),
                    );
                  }

                  return _buildMessageItem(
                      message, lastMessage, isFirst, index, messages);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMessageItem(MessageEntity message, MessageEntity lastMessage,
      bool isFirst, int index, List<MessageEntity> messages) {
    final cubit = context.read<ChatCubit>();
    final isSelected = cubit.selectedMessageIds.contains(message.messageId);

    return GestureDetector(
      onLongPress: () =>
          cubit.handleMessageLongPress(message, widget.receiverId),
      onTap: () => cubit.handleMessageTap(message),
      child: Column(
        children: [
          if (index == 0 ||
              !DateConverter.isSameDay(
                  message.timeSent, messages[index - 1].timeSent))
            ChatTimeCard(dateTime: message.timeSent),
          Stack(
            children: [
              // Message Card
              message.receiverId == widget.receiverId
                  ? MyMessageCard(
                      message: message,
                      lastMessage: lastMessage,
                      isFirst: isFirst)
                  : SenderMessageCard(
                      message: message,
                      lastMessage: lastMessage,
                      isFirst: isFirst),

              // Highlight Overlay
              if (isSelected)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
