import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/extensions/time_extension.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/functions/navigator.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../data/models/user_model.dart';
import '../../../../../../domain/entities/user_entity.dart';
import '../../../../../components/profile_image/my_cached_net_image.dart';
import 'no_chat_appbar.dart';

class UserInfoAppBar extends StatelessWidget {
  final String receiverId;

  const UserInfoAppBar({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    final isMe = receiverId == FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<UserEntity>(
      stream: _getUserById(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingChatAppBar();
        }

        final user = snapshot.data!;
        return GestureDetector(
          onTap: () {
            isMe
                ? navigateTo(context, Routes.profile, arguments: true)
                : navigateToUserProfile(context, user, true);
          },
          child: Row(
            children: [
              Hero(
                tag: user.uID,
                child:
                    MyCachedNetImage(imageUrl: user.profilePic, radius: 19.sp),
              ),
              SizedBox(width: 8.w),
              Container(
                constraints: BoxConstraints(maxWidth: context.width * 0.58),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isMe ? '${user.name} (You)' : user.name,
                      style: TextStyle(color: AppColors.white, fontSize: 16.sp),
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
                        fontSize: isMe ? 11.sp : 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Stream<UserModel> _getUserById() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data() ?? {}));
  }
}
