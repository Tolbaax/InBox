import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/extensions/time_extension.dart';
import 'package:inbox/core/params/chat/set_chat_message_seen_params.dart';
import 'package:inbox/domain/entities/message_entity.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import 'package:inbox/presentation/controllers/chat/chat_states.dart';
import '../../../../../../../core/functions/date_convertor.dart';
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
  int previousMessageCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        return StreamBuilder<List<MessageEntity>>(
          stream: ChatCubit.get(context).getChatMessages(widget.receiverId),
          builder: (context, snapshot) {
            return ConditionalBuilder(
              condition: snapshot.hasData,
              builder: (context) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final currentMessageCount = snapshot.data!.length;

                  // Check if new messages have arrived
                  if (currentMessageCount > previousMessageCount) {
                    // Scroll to the bottom when new messages arrive
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    });

                    // Update the previous message count
                    previousMessageCount = currentMessageCount;
                  }

                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final message = snapshot.data![index];

                        final lastMessage = snapshot.data!.last;

                        var previousMessage =
                            index > 0 ? snapshot.data![index - 1] : null;

                        // Check if the current message should have a small bubble for the first message
                        bool isFirst = index == 0 ||
                            message.senderId != previousMessage?.senderId ||
                            !message.timeSent
                                .isSameDay(previousMessage!.timeSent);

                        // Set chat message seen
                        if (!message.isSeen &&
                            message.receiverId != widget.receiverId) {
                          ChatCubit.get(context).setChatMessageSeen(
                            SetChatMessageSeenParams(
                              receiverId: widget.receiverId,
                              messageId: message.messageId,
                            ),
                          );
                        }

                        return Column(
                          children: [
                            if (index == 0 ||
                                !DateConverter.isSameDay(
                                  message.timeSent,
                                  snapshot.data![index - 1].timeSent,
                                ))
                              ChatTimeCard(dateTime: message.timeSent),
                            if (message.receiverId == widget.receiverId)
                              MyMessageCard(
                                message: message,
                                lastMessage: lastMessage,
                                isFirst: isFirst,
                              ),
                            if (message.receiverId != widget.receiverId)
                              SenderMessageCard(
                                message: message,
                                isFirst: isFirst,
                                lastMessage: lastMessage,
                              ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              fallback: (context) => const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
