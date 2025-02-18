import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/presentation/view/chats/widgets/camera/select_chat_image.dart';
import '../../../../core/shared/common.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../controllers/chat/chat_cubit.dart';
import '../../view/chats/widgets/chat/chat_field/send_message_button.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController messageController;
  final bool isReply;
  final bool isMessageEmpty;
  final String receiverId;
  final String name;
  final bool isCameraRev;
  final Color textColor;

  const MessageInputField({
    super.key,
    required this.messageController,
    required this.isReply,
    required this.isMessageEmpty,
    required this.receiverId,
    required this.name,
    required this.isCameraRev,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);

    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: isCameraRev ? 0.0 : 7.0.w,
          end: isCameraRev ? 0.0 : 7.0.w,
          bottom: 5.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isCameraRev
                    ? context.width
                    : context.width - 22.0.sp * 2 - 20.0.w,
                maxHeight: context.height * 0.25,
              ),
              decoration: BoxDecoration(
                color:
                    isCameraRev ? AppColors.charlestonGreen : AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isReply ? 0.0 : 25.0.sp),
                  topRight: Radius.circular(isReply ? 0.0 : 25.0.sp),
                  bottomLeft: Radius.circular(25.0.sp),
                  bottomRight: Radius.circular(25.0.sp),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => cubit.toggleEmojiKeyboard(isCameraRev),
                    splashRadius: 20.0.sp,
                    icon: Icon(
                      cubit.isShowEmoji
                          ? FontAwesomeIcons.keyboard
                          : FontAwesomeIcons.faceGrinWide,
                      size: 20.0.sp,
                    ),
                    color: isCameraRev
                        ? AppColors.white
                        : AppColors.black.withOpacity(0.5),
                  ),
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                            isCameraRev ? context.width : context.width * 0.69,
                      ),
                      child: TextField(
                        controller: messageController,
                        focusNode: isCameraRev
                            ? cubit.cameraFocusNode
                            : cubit.chatFocusNode,
                        onTap: () => cubit.hideEmojiContainer(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                        minLines: 1,
                        textDirection:
                            isFirstCharacterArabic(messageController.text)
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: isCameraRev
                              ? AppStrings.addCaption
                              : AppStrings.message,
                          hintStyle: TextStyle(
                            fontSize: 15.0.sp,
                            color: isCameraRev
                                ? AppColors.white
                                : AppColors.grayRegular,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsetsDirectional.symmetric(
                            vertical: 6.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isCameraRev)
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(-45 / 360),
                      child: IconButton(
                        onPressed: () {},
                        splashRadius: 20.0.sp,
                        icon: const Icon(Icons.attach_file),
                        color: AppColors.black.withOpacity(0.5),
                      ),
                    ),
                  if (isMessageEmpty)
                    SelectChatImage(
                        receiverId: receiverId, name: name, isCamera: true),
                ],
              ),
            ),
          ),
          if (!isCameraRev)
            SendMessageButton(
              messageController: messageController,
              receiverId: receiverId,
              isMessageEmpty: isMessageEmpty,
            ),
        ],
      ),
    );
  }
}
