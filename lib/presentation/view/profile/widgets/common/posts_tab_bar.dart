import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_strings.dart';
import 'get_my_posts_with_videos.dart';
import 'get_my_posts_without_videos.dart';

List<Tab> tabs = const [
  Tab(text: AppStrings.posts),
  Tab(text: AppStrings.videos),
];

class PostsTabBar extends StatelessWidget {
  final String uID;
  final bool tapFromMyProfile, tapFromUserProfile;

  const PostsTabBar({
    super.key,
    required this.uID,
    required this.tapFromMyProfile,
    required this.tapFromUserProfile,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            tabs: tabs,
            indicatorWeight: 0.5.h,
          ),
          Expanded(
            child: TabBarView(
              children: [
                //Tab Posts
                GetMyPostsWithoutVideos(
                  uID: uID,
                  tapFromMyProfile: tapFromMyProfile,
                  tapFromUserProfile: tapFromUserProfile,
                ),
                //Tab Videos
                GetMyPostsWithVideos(
                  uID: uID,
                  tapFromMyProfile: tapFromMyProfile,
                  tapFromUserProfile: tapFromUserProfile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
