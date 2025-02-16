import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/time_extension.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../core/injection/injector.dart';
import 'chat_card.dart';

class MessageCard extends StatelessWidget {
  final UserChatEntity chat;

  const MessageCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = sl<FirebaseAuth>();
    final uID = firebaseAuth.currentUser!.uid;

    return StreamBuilder<int>(
      stream: sl<MessagesCubit>().getNumOfMessageNotSeen(chat.userId),
      builder: (context, snapshot) {
        int unseenMessageCount = snapshot.data ?? 0;
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            ChatCard(chat: chat, unseenMessageCount: unseenMessageCount),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 13.h, end: 14.w),
              child: Text(
                chat.timeSent.chatContactTime,
                maxLines: 1,
                style: TextStyle(
                  color: unseenMessageCount > 0 &&
                          uID != chat.lastMessageSenderId &&
                          !chat.isSeen
                      ? AppColors.primary
                      : AppColors.blackOlive.withOpacity(0.7),
                  fontSize: 11.1.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: '',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
