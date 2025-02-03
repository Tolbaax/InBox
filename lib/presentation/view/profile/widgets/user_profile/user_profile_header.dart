import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/functions/navigator.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../components/buttons/profile_button.dart';
import '../common/profile_header.dart';
import 'follow_button.dart';

class UserProfileHeader extends StatelessWidget {
  final UserEntity user;

  const UserProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 15.0.sp),
      child: Column(
        children: [
          ProfileHeader(user: user),
          Row(
            children: [
              Expanded(
                child: FollowButton(
                  followUserID: user.uID,
                ),
              ),
              SizedBox(
                width: 12.0.w,
              ),
              Expanded(
                child: ProfileButton(
                  onTap: () => navigateTo(
                    context,
                    Routes.chat,
                    arguments: {'uId': user.uID, 'name': user.name},
                  ),
                  text: AppStrings.message,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
