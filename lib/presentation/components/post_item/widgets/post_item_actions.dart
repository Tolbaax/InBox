import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/params/post/like_post_params.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:inbox/domain/entities/post_entity.dart';
import 'package:inbox/presentation/components/post_item/widgets/post_action_icon.dart';
import 'package:inbox/presentation/controllers/post/post_cubit.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../core/injection/injector.dart';
import 'video_manager.dart';

class PostItemActions extends StatelessWidget {
  final PostEntity post;

  const PostItemActions({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PostCubit>(context);
    final firebaseAuth = sl<FirebaseAuth>();
    final uID = firebaseAuth.currentUser!.uid;
    final isLiked = post.likes.contains(uID);

    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: context.width * 0.04, end: context.width * 0.04),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 5.0.h),
            child: Row(
              children: [
                if (post.likes.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.heart_circle_fill,
                        size: 16.5.sp,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 3.0.sp,
                      ),
                      Text(
                        '${post.likes.length}',
                        style: TextStyle(
                          color: AppColors.grayRegular,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                if (post.commentCount > 0)
                  Row(
                    children: [
                      Text(
                        post.commentCount.toString(),
                        style: TextStyle(
                          color: AppColors.grayRegular,
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 3.0.sp,
                      ),
                      Text(
                        post.commentCount == 1
                            ? AppStrings.comment
                            : AppStrings.comments,
                        style: TextStyle(
                          color: AppColors.grayRegular,
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PostActionIcon(
                onTap: () async => await cubit.likePost(
                  LikePostParams(
                    postID: post.postID,
                    likes: post.likes,
                  ),
                ),
                icon: isLiked
                    ? CupertinoIcons.heart_circle_fill
                    : CupertinoIcons.heart,
                text: AppStrings.love,
                iconColor: isLiked ? Colors.red : AppColors.grayRegular,
              ),
              PostActionIcon(
                onTap: () {
                  navigateTo(context, Routes.comment, arguments: post.postID);
                  sl<VideoManager>().stopCurrentVideo();
                },
                icon: CupertinoIcons.text_bubble,
                text: AppStrings.comment,
              ),
              PostActionIcon(
                onTap: () {},
                icon: Icons.share,
                text: AppStrings.share,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
