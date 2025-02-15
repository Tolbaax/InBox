import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/presentation/controllers/user/user_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../core/injection/injector.dart';
import '../../../../components/buttons/profile_button.dart';
import 'package:shimmer/shimmer.dart';

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
          return Center(child: Text(snapshot.error.toString()));
        }

        final isLoading = snapshot.connectionState == ConnectionState.waiting;

        if (isLoading) {
          return _buildShimmerEffect();
        }

        final userData = snapshot.data?.data();
        if (userData == null) return _buildShimmerEffect();

        bool isFollowing = userData['following']?.contains(followUserID) ?? false;

        return ProfileButton(
          onTap: () {
            if (isFollowing) {
              cubit.unFollowUser(followUserID);
            } else {
              cubit.followUser(followUserID);
            }
          },
          text: isFollowing ? AppStrings.unFollow : AppStrings.follow,
          color: !isFollowing ? AppColors.primary.withOpacity(0.94) : null,
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 28.0.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
