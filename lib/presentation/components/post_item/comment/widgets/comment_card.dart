import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/functions/navigator.dart';
import '../../../../../core/injection/injector.dart';
import '../../../../../domain/entities/comment_entity.dart';
import '../../../../controllers/user/user_cubit.dart';
import '../../../profile_image/my_cached_net_image.dart';

class CommentCard extends StatelessWidget {
  final CommentEntity comment;
  final CommentEntity lastItem;

  const CommentCard({super.key, required this.comment, required this.lastItem});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = sl<FirebaseAuth>();

    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 10.0.sp, end: 15.0.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  final currentUser = firebaseAuth.currentUser;
                  final userEntity =
                      await sl<UserCubit>().getUserById(comment.uID);

                  if (currentUser != null && comment.uID == currentUser.uid) {
                    if (context.mounted) {
                      navigateTo(context, Routes.profile, arguments: false);
                    }
                  } else {
                    if (context.mounted) {
                      navigateToUserProfile(context, userEntity, false);
                    }
                  }
                },
                child: MyCachedNetImage(
                  imageUrl: comment.profilePic,
                  radius: 20.5.sp,
                ),
              ),
              SizedBox(
                width: 5.0.w,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: context.width - 40.0.sp * 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10.0.sp),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 8.0.sp,
                          vertical: 5.0.sp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: context.width * 0.75,
                              ),
                              child: Text(
                                comment.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: context.width * 0.75,
                              ),
                              child: ReadMoreText(
                                comment.commentText,
                                trimLines: 13,
                                trimMode: TrimMode.Line,
                                trimExpandedText: ' ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 1.5.h, start: 2.5.sp),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: context.width * 0.75,
                        ),
                        child: Text(
                          timeago.format(DateTime.parse(comment.publishTime)),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (comment == lastItem) SizedBox(height: 70.0.h),
      ],
    );
  }
}
