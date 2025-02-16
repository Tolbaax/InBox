import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../components/profile_image/my_cached_net_image.dart';
import '../../../../components/profile_image/show_image.dart';
import '../my_profile/my_profile_statistics.dart';
import 'name_and_bio.dart';
import '../user_profile/user_profile_statistics.dart';

class ProfileHeader extends StatelessWidget {
  final UserEntity user;
  final bool isMe;

  const ProfileHeader({super.key, required this.user, this.isMe = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Hero(
              tag: user.profilePic,
              child: ShowImageWithLongPress(
                imageUrl: user.profilePic,
                child: MyCachedNetImage(
                  imageUrl: user.profilePic,
                  radius: 40.0.sp,
                ),
              ),
            ),
            if (isMe)
              MyProfileStatistics(user: user)
            else
              UserProfileStatistics(uID: user.uID),
          ],
        ),
        SizedBox(
          height: 10.0.h,
        ),
        NameAndBio(user: user),
        SizedBox(
          height: 10.0.h,
        ),
      ],
    );
  }
}
