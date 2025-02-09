import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/presentation/controllers/user/user_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../core/injection/injector.dart';
import '../../../../components/buttons/profile_button.dart';

class FollowButton extends StatelessWidget {
  final String followUserID;

  const FollowButton({super.key, required this.followUserID});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();

    final firestore = sl<FirebaseFirestore>();

    final snapshot =
        firestore.collection('users').doc(cubit.userEntity!.uID).snapshots();

    return StreamBuilder(
      stream: snapshot,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        bool isFollowing =
            snapshot.data!.data()!['following'].contains(followUserID);
        return ProfileButton(
          onTap: () {
            if (isFollowing) {
              cubit.unFollowUser(followUserID);
            } else {
              cubit.followUser(followUserID);
            }
            UserCubit.get(context).getCurrentUser();
          },
          text: isFollowing ? AppStrings.unFollow : AppStrings.follow,
          color: !isFollowing ? AppColors.primary.withOpacity(0.94) : null,
        );
      },
    );
  }
}
