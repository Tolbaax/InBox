import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/data/models/user_model.dart';
import 'package:inbox/domain/entities/user_entity.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../components/profile_image/my_cached_net_image.dart';

class UserCard extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const UserCard({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: snapshot.data!.docs.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 8.0.h);
      },
      itemBuilder: (context, index) {
        var data = snapshot.data!.docs[index];
        UserEntity user = UserModel.fromJson(data.data());

        return InkWell(
          overlayColor: WidgetStateProperty.all(
            AppColors.gray.withOpacity(0.15),
          ),
          onTap: () async {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null && data.id == currentUser.uid) {
              // Navigate to user's own profile page
              navigateTo(context, Routes.profile, arguments: true);
            } else {
              // Navigate to selected user's profile page
              navigateToUserProfile(context, user, true);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: user.uID,
                child: MyCachedNetImage(
                  imageUrl: data['profilePic'],
                  radius: 28.0.sp,
                ),
              ),
              SizedBox(
                width: 10.0.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: context.width * 0.65,
                    ),
                    child: Text(
                      data['username'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: context.width * 0.65,
                    ),
                    child: Text(
                      data['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.blackOlive,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
