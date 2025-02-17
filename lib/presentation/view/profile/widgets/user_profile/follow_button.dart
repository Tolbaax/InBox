import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inbox/presentation/controllers/user/user_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../core/injection/injector.dart';
import '../../../../components/buttons/profile_button.dart';

class FollowButton extends StatefulWidget {
  final String followUserID;

  const FollowButton({super.key, required this.followUserID});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  final ValueNotifier<bool> isFollowing = ValueNotifier(false);
  StreamSubscription<DocumentSnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    final cubit = sl<UserCubit>();
    final firestore = sl<FirebaseFirestore>();

    _subscription = firestore
        .collection('users')
        .doc(cubit.userEntity?.uID)
        .snapshots()
        .listen((snapshot) {
      final userData = snapshot.data();
      final newFollowingState =
          userData?['following']?.contains(widget.followUserID) ?? false;

      // Update notifier only if there's an actual change
      if (isFollowing.value != newFollowingState) {
        isFollowing.value = newFollowingState;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = sl<UserCubit>();

    return ValueListenableBuilder<bool>(
      valueListenable: isFollowing,
      builder: (context, following, child) {
        return ProfileButton(
          onTap: () async {
            if (following) {
              await cubit.unFollowUser(widget.followUserID);
            } else {
              await cubit.followUser(widget.followUserID);
            }
          },
          text: following ? AppStrings.unFollow : AppStrings.follow,
          color: following ? null : AppColors.primary.withOpacity(0.94),
        );
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    isFollowing.dispose();
    super.dispose();
  }
}

