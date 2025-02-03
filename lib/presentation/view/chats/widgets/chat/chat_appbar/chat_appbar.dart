import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/extensions/time_extension.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/utils/app_strings.dart';
import '../../../../../../../config/routes/app_routes.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../data/models/user_model.dart';
import '../../../../../../domain/entities/user_entity.dart';
import '../../../../../components/profile_image/my_cached_net_image.dart';
import 'no_chat_appbar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String receiverId;

  const ChatAppBar({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    bool isMe = receiverId == FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<UserEntity>(
      stream: getUserById(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingChatAppBar();
        }

        UserEntity user = snapshot.data!;

        return AppBar(
          backgroundColor: AppColors.policeBlue,
          leading: BackButton(color: AppColors.white),
          leadingWidth: 38.0.w,
          titleSpacing: 0.0,
          toolbarHeight: kToolbarHeight,
          title: GestureDetector(
            onTap: () {
              if (isMe) {
                navigateTo(context, Routes.profile, arguments: true);
              } else {
                navigateToUserProfile(context, user, true);
              }
            },
            child: Row(
              children: [
                Hero(
                  tag: user.uID,
                  child: MyCachedNetImage(
                    imageUrl: user.profilePic,
                    radius: 19.0.sp,
                  ),
                ),
                SizedBox(width: 8.0.w),
                Container(
                  constraints: BoxConstraints(maxWidth: context.width * 0.58),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isMe ? '${user.name} (You)' : user.name,
                        style: TextStyle(
                            color: AppColors.white, fontSize: 16.0.sp),
                      ),
                      SizedBox(height: 1.8.h),
                      Text(
                        isMe
                            ? AppStrings.messageYourself
                            : (user.isOnline
                                ? AppStrings.online
                                : user.lastSeen.lastSeen),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: isMe ? 11.0.sp : 10.0.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Stream<UserModel> getUserById() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data() ?? {}));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1.0.h);
}
