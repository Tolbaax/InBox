import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/auth/auth_cubit.dart';
import '../../../controllers/auth/auth_states.dart';
import '../../../controllers/user/user_cubit.dart';
import '../widgets/my_profile/my_profile_header.dart';
import '../widgets/common/posts_tab_bar.dart';
import '../widgets/my_profile/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  final bool fromSearch;

  const ProfileScreen({super.key, required this.fromSearch});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null || UserCubit.get(context).userEntity == null) {
          return const Scaffold(
            appBar: ProfileAppBar(fromSearch: false),
            body: MyProfileHeader(),
          );
        }

        final uID = user.uid;

        return Scaffold(
          appBar: ProfileAppBar(fromSearch: fromSearch),
          body: NestedScrollView(
            physics: const RangeMaintainingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: MyProfileHeader(),
                ),
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
