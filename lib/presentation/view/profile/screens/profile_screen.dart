import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection/injector.dart';
import '../../../controllers/user/user_cubit.dart';
import '../../../controllers/user/user_states.dart';
import '../widgets/my_profile/my_profile_header.dart';
import '../widgets/common/posts_tab_bar.dart';
import '../widgets/my_profile/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  final bool fromSearch;

  const ProfileScreen({super.key, required this.fromSearch});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = sl<FirebaseAuth>();
    final user = firebaseAuth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(strokeWidth: 1.2)),
      );
    }

    final uID = user.uid;

    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        final userCubit = sl<UserCubit>();

        if (userCubit.userEntity == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(strokeWidth: 1.2)),
          );
        }

        return Scaffold(
          appBar: ProfileAppBar(fromSearch: fromSearch),
          body: NestedScrollView(
            physics: const RangeMaintainingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(child: MyProfileHeader()),
              ];
            },
            body: PostsTabBar(
              uID: uID,
              tapFromMyProfile: true,
              tapFromUserProfile: false,
            ),
          ),
        );
      },
    );
  }
}
