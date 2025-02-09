import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/time_extension.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../core/injection/injector.dart';
import '../../../../controllers/chat/chat_cubit.dart';
import 'chat_card.dart';

class MessageCard extends StatelessWidget {
  final UserChatEntity chat;

  const MessageCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = sl<FirebaseAuth>();
    final uID = firebaseAuth.currentUser!.uid;

    return StreamBuilder<int>(
      stream: ChatCubit.get(context).getNumOfMessageNotSeen(chat.userId),
      builder: (context, snapshot) {
        int unseenMessageCount = snapshot.data ?? 0;

        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 13.0.h),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ChatCard(chat: chat, unseenMessageCount: unseenMessageCount),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 7.5.h),
                child: Text(
                  chat.timeSent.chatContactTime,
                  maxLines: 1,
                  style: TextStyle(
                    color: unseenMessageCount > 0 &&
                            uID != chat.lastMessageSenderId
                        ? AppColors.primary
                        : AppColors.blackOlive.withOpacity(0.7),
                    fontSize: 11.1.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: '',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
