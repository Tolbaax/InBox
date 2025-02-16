import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../core/injection/injector.dart';
import '../../../../components/profile_image/my_cached_net_image.dart';
import 'unseen_message_circle.dart';

class ChatCard extends StatelessWidget {
  final UserChatEntity chat;
  final int unseenMessageCount;

  const ChatCard(
      {super.key, required this.chat, required this.unseenMessageCount});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = sl<FirebaseAuth>();
    final String uID = firebaseAuth.currentUser!.uid;
    final bool isMe = uID == chat.userId;
    final cubit = context.watch<MessagesCubit>();
    final bool isSelected = cubit.selectedChatIds.contains(chat.userId);

    return InkWell(
        onLongPress: () => cubit.handleChatLongPress(chat.userId),
        onTap: () {
          if (cubit.isChatSelecting) {
            cubit.handleChatTap(chat.userId);
          } else {
            navigateTo(
              context,
              Routes.chat,
              arguments: {
                'uId': chat.userId,
                'name': chat.name,
                'imageUrl': chat.profilePic,
              },
            );
            FocusScope.of(context).unfocus();
          }
        },
        overlayColor: WidgetStateProperty.all(
          AppColors.gray.withOpacity(0.1),
        ),
        child: Container(
          height: 65.h,
          padding: EdgeInsetsDirectional.only(start: 12.w, top: 6.h, end: 13.w),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28.0.sp,
                  backgroundColor: AppColors.primary.withOpacity(0.5),
                  child: Hero(
                    tag: chat.userId,
                    child: MyCachedNetImage(
                      imageUrl: chat.profilePic,
                      radius: 28.5.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.5.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.5.h),
                    Text(
                      isMe ? '${chat.name} (You)' : chat.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      height: 6.0.h,
                    ),
                    Row(
                      children: [
                        if (uID == chat.lastMessageSenderId)
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 3.0.w),
                            child: Icon(
                              Icons.done_all_outlined,
                              size: 16.0.sp,
                              color: chat.isSeen
                                  ? AppColors.primary
                                  : AppColors.grayRegular,
                            ),
                          ),
                        if (chat.lastMessage == 'GIF')
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 3.0.w),
                            child: Icon(Icons.gif_box_rounded,
                                size: 15.0.sp, color: AppColors.amethyst),
                          ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: context.width * 0.65,
                          ),
                          child: Text(
                            chat.lastMessage,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppColors.blackOlive.withOpacity(0.85),
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                if (uID != chat.lastMessageSenderId)
                  unseenMessageCount > 0 && !chat.isSeen
                      ? UnseenMessagesCircle(
                          unseenMessageCount: unseenMessageCount)
                      : const SizedBox.shrink(),
              ],
            ),
          ),
        ));
  }
}
