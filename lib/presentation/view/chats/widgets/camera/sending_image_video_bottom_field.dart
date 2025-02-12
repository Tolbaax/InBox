import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import '../../../../../../core/params/chat/message_params.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../controllers/chat/chat_states.dart';
import '../chat/chat_field/emoji_picker_widget.dart';
import '../../../../components/text_fields/message_input_field.dart';

class SendingImageVideoBottomField extends StatelessWidget {
  final String receiverId;
  final String name;
  final File messageFile;
  final MessageType messageType;

  const SendingImageVideoBottomField({
    super.key,
    required this.receiverId,
    required this.name,
    required this.messageFile,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        final cubit = ChatCubit.get(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 13.0.sp),
              child: MessageInputField(
                messageController: controller,
                isMessageEmpty: false,
                isReply: false,
                receiverId: receiverId,
                name: name,
                isCameraRev: true,
                textColor: AppColors.white,
              ),
            ),
            Container(
              height: context.height * 0.074,
              width: context.width,
              color: AppColors.black.withOpacity(0.45),
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 13.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: context.width * 0.7),
                      padding: EdgeInsetsDirectional.all(6.0.sp),
                      decoration: BoxDecoration(
                          color: AppColors.charlestonGreen,
                          borderRadius:
                              BorderRadiusDirectional.circular(12.0.sp)),
                      child: Text(
                        name,
                        maxLines: 1,
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primary,
                      child: GestureDetector(
                        onTap: () {
                          cubit.sendFileMessage(
                            MessageParams(
                              message: controller.text.trim(),
                              receiverId: receiverId,
                              messageType: messageType,
                              messageFile: cubit.messageImage == null
                                  ? messageFile
                                  : File(cubit.messageImage!.path),
                            ),
                          );
                          int count = 0;
                          Navigator.of(context)
                              .popUntil((route) => count++ >= 2);
                          cubit.messageImage = null;
                          controller.clear();
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (cubit.isShowEmoji)
              EmojiPickerWidget(
                messageController: controller,
                isShowEmoji: cubit.isShowEmoji,
                isCameraRev: true,
                onGifButtonTap: () {},
              ),
          ],
        );
      },
    );
  }
}
