import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/enums/message_type.dart';

import '../../../../../../../core/params/chat/message_params.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../controllers/chat/chat_cubit.dart';

class SendMessageButton extends StatelessWidget {
  final TextEditingController messageController;
  final String receiverId;
  final bool isMessageEmpty;

  const SendMessageButton({
    super.key,
    required this.messageController,
    required this.receiverId,
    required this.isMessageEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (messageController.text.trim().isNotEmpty) {
          ChatCubit.get(context).sendTextMessage(
            MessageParams(
              message: messageController.text.trim(),
              receiverId: receiverId,
              messageReplay: ChatCubit.get(context).messageReplay,
              messageType: messageController.text.trim().isEmpty
                  ? MessageType.gif
                  : MessageType.text,
            ),
          );
          messageController.clear();
        }
      },
      child: CircleAvatar(
        radius: 21.5.sp,
        backgroundColor: AppColors.primary,
        child: Icon(
          // isMessageEmpty || messageController.text.trim().isEmpty
          //     ? Icons.mic :
          Icons.send,
          color: AppColors.white,
        ),
      ),
    );
  }
}
