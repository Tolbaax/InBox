import 'package:flutter/material.dart';
import '../../../../core/injection/injector.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../controllers/user/user_cubit.dart';
import '../widgets/common/posts_tab_bar.dart';
import '../widgets/user_profile/user_profile_appbar.dart';
import '../widgets/user_profile/user_profile_header.dart';

class UserProfile extends StatelessWidget {
  final String uID;

  const UserProfile({super.key, required this.uID});

  Future<UserEntity?> _fetchUser() async {
    try {
      return await sl<UserCubit>().getUserById(uID);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserEntity?>(
        future: _fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 1.2));
          } else if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Failed to load user')),
            );
          }

          final user = snapshot.data!;

          return Scaffold(
            appBar: UserProfileAppBar(uID: uID, username: user.username),
            body: NestedScrollView(
              physics: const RangeMaintainingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(child: UserProfileHeader(user: user)),
              ],
              body: PostsTabBar(
                uID: user.uID,
                tapFromMyProfile: false,
                tapFromUserProfile: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
