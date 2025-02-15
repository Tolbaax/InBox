import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/presentation/components/post_item/widgets/video_manager.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/format_post_time.dart';
import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../core/injection/injector.dart';
import '../../../../domain/entities/post_entity.dart';
import '../../profile_image/my_cached_net_image.dart';
import 'custom_pop_menu.dart';

class PostItemHeader extends StatelessWidget {
  final PostEntity post;
  final bool tapFromMyProfile, tapFromUserProfile;

  const PostItemHeader({
    super.key,
    required this.post,
    this.tapFromMyProfile = false,
    this.tapFromUserProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isTapped = false;
    final firebaseAuth = sl<FirebaseAuth>();

    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        GestureDetector(
          onTap: () async {
            if (isTapped) return;
            isTapped = true;

            final currentUser = firebaseAuth.currentUser;
            sl<VideoManager>().stopCurrentVideo();

            if (currentUser != null && post.uID == currentUser.uid) {
              if (!tapFromMyProfile) {
                if (context.mounted) {
                  navigateTo(context, Routes.profile, arguments: false);
                }
              }
            } else {
              if (!tapFromUserProfile) {
                if (context.mounted) {
                  navigateToUserProfile(context: context, uID: post.uID);
                }
              }
            }
            isTapped = false;
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22.0,
                backgroundColor: AppColors.primary.withOpacity(0.5),
                child: MyCachedNetImage(
                  imageUrl: post.profilePic,
                  radius: 18.5.sp,
                ),
              ),
              SizedBox(
                width: 6.5.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: context.width * 0.7,
                        ),
                        child: Text(
                          post.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.sp,
                  ),
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: context.width * 0.7,
                        ),
                        child: Text(
                          formatPostTime(post.publishTime),
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.blackOlive.withOpacity(0.85),
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 3.5.sp, end: 2.5.sp),
                        child: CircleAvatar(
                          radius: 1.2.sp,
                          backgroundColor:
                              AppColors.blackOlive.withOpacity(0.6),
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.earthAfrica,
                        color: AppColors.blackOlive.withOpacity(0.78),
                        size: 9.5.sp,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        CustomPubMenuButton(
          post: post,
          child: IconButton(
            onPressed: null,
            alignment: AlignmentDirectional.topEnd,
            padding: EdgeInsetsDirectional.only(top: 2.5.sp, end: 5.0.sp),
            icon: Icon(
              FontAwesomeIcons.ellipsis,
              size: 17.0.sp,
              color: AppColors.blackOlive.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
