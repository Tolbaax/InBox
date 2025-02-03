import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/post_entity.dart';
import 'widgets/post_item_actions.dart';
import 'widgets/post_item_header.dart';
import 'widgets/post_item_image.dart';
import 'widgets/post_item_text.dart';
import 'widgets/post_item_video.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;
  final PostEntity lastItem;
  final double lastItemHeight;
  final bool tapFromMyProfile, tapFromUserProfile;

  const PostItem({
    super.key,
    required this.post,
    required this.lastItem,
    required this.lastItemHeight,
    this.tapFromMyProfile = false,
    this.tapFromUserProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostItemHeader(
            post: post,
            tapFromMyProfile: tapFromMyProfile,
            tapFromUserProfile: tapFromUserProfile,
          ),
          if (post.postText.isNotEmpty) PostItemText(post: post),
          if (post.imageUrl.isNotEmpty)
            PostItemImage(imageUrl: post.imageUrl, isGif: false),
          if (post.gifUrl.isNotEmpty)
            PostItemImage(imageUrl: post.gifUrl, isGif: true),
          if (post.videoUrl.isNotEmpty) PostItemVideo(videoUrl: post.videoUrl),
          PostItemActions(post: post),
          if (post == lastItem) SizedBox(height: lastItemHeight),
        ],
      ),
    );
  }
}
