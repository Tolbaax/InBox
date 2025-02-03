import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/params/chat/message_reply.dart';
import 'package:inbox/core/shared/common.dart';
import 'package:inbox/core/utils/app_colors.dart';

import '../../../../../components/text_fields/message_input_field.dart';
import '../../../../../controllers/chat/chat_cubit.dart';
import '../../../../../controllers/chat/chat_states.dart';
import '../message_card/message_replay_preview.dart';
import 'emoji_picker_widget.dart';

class BottomChatField extends StatefulWidget {
  final String receiverId;
  final String name;

  const BottomChatField(
      {super.key, required this.receiverId, required this.name});

  @override
  BottomChatFieldState createState() => BottomChatFieldState();
}

class BottomChatFieldState extends State<BottomChatField> {
  final messageController = TextEditingController();
  bool isMessageEmpty = true;

  @override
  void initState() {
    super.initState();
    messageController.addListener(() {
      setState(() {
        isMessageEmpty = messageController.text.trim().isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        MessageReplay? messageReplay = ChatCubit.get(context).messageReplay;
        final bool isReply = messageReplay != null;
        final cubit = ChatCubit.get(context);

        return WillPopScope(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isReply)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.width - 22.0.sp * 2 - 13.0.w,
                  ),
                  child: MessageReplayPreview(messageReplay: messageReplay),
                ),
              MessageInputField(
                messageController: messageController,
                isReply: isReply,
                isMessageEmpty: isMessageEmpty,
                receiverId: widget.receiverId,
                isCameraRev: false,
                name: widget.name,
                textColor: AppColors.black,
              ),
              if (cubit.isShowEmoji)
                EmojiPickerWidget(
                  messageController: messageController,
                  isShowEmoji: cubit.isShowEmoji,
                  isCameraRev: false,
                  onGifButtonTap: () async {
                    if (await checkInternetConnectivity()) {
                      if (context.mounted) {
                        selectGif(cubit, context, widget.receiverId);
                      }
                    }
                  },
                ),
            ],
          ),
          onWillPop: () {
            if (cubit.isShowEmoji) {
              cubit.hideEmojiContainer();
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
