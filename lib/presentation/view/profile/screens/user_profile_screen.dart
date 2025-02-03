import 'package:flutter/material.dart';
import '../../../../domain/entities/user_entity.dart';
import '../widgets/common/posts_tab_bar.dart';
import '../widgets/user_profile/user_profile_appbar.dart';
import '../widgets/user_profile/user_profile_header.dart';

class UserProfile extends StatelessWidget {
  final UserEntity user;

  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserProfileAppBar(user: user),
      body: NestedScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: UserProfileHeader(user: user),
            ),
          ];
        },
        body: PostsTabBar(
          uID: user.uID,
          tapFromMyProfile: false,
          tapFromUserProfile: true,
        ),
      ),
    );
  }
}
