import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/extensions/time_extension.dart';
import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/functions/navigator.dart';
import '../../../../../../core/injection/injector.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../components/common/custom_shimmer.dart';
import '../../../../../components/profile_image/my_cached_net_image.dart';

class UserInfoAppBar extends StatefulWidget {
  final String receiverId;
  final String name;
  final String imageUrl;

  const UserInfoAppBar({
    super.key,
    required this.receiverId,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<UserInfoAppBar> createState() => _UserInfoAppBarState();
}

class _UserInfoAppBarState extends State<UserInfoAppBar> {
  final lastSeenNotifier = LastSeenNotifier();

  @override
  void initState() {
    super.initState();
    lastSeenNotifier.listenToLastSeen(widget.receiverId);
  }

  @override
  void dispose() {
    lastSeenNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = sl<FirebaseAuth>();
    final isMe = widget.receiverId == firebaseAuth.currentUser!.uid;

    return GestureDetector(
      onTap: () async {
        if (context.mounted) {
          isMe
              ? navigateTo(context, Routes.profile, arguments: true)
              : navigateToUserProfile(
                  context: context, uID: widget.receiverId, fromSearch: true);
        }
      },
      child: Row(
        children: [
          MyCachedNetImage(imageUrl: widget.imageUrl, radius: 19.sp),
          SizedBox(width: 8.w),
          Container(
            constraints: BoxConstraints(maxWidth: context.width * 0.58),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMe ? '${widget.name} (You)' : widget.name,
                  style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 1.8.h),

                //Listen for updates only when `isOnline` or `lastSeen` changes
                ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: lastSeenNotifier,
                  builder: (context, state, _) {
                    final bool isLoading = state.isEmpty;
                    final bool isOnline = state['isOnline'] ?? false;
                    final DateTime? lastSeen = state['lastSeen'] != null
                        ? DateTime.fromMicrosecondsSinceEpoch(state['lastSeen'])
                        : null;
                    return SizedBox(
                      height: context.height * 0.017,
                      child: isLoading
                          ? CustomShimmer.shimmerText(
                              width: 140.w, height: 12.h)
                          : Text(
                              isMe
                                  ? AppStrings.messageYourself
                                  : (isOnline
                                      ? AppStrings.online
                                      : lastSeen?.lastSeen ?? ''),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: isMe ? 11.sp : 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LastSeenNotifier extends ValueNotifier<Map<String, dynamic>> {
  LastSeenNotifier() : super({});
  StreamSubscription? _subscription;

  void listenToLastSeen(String receiverId) {
    _subscription = sl<FirebaseFirestore>()
        .collection('users')
        .doc(receiverId)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data();
      if (data == null) return;

      final newState = {
        'isOnline': data['isOnline'] ?? false,
        'lastSeen': data['lastSeen'],
      };

      // Only update ValueNotifier if there’s a real change
      if (value.isEmpty ||
          value['isOnline'] != newState['isOnline'] ||
          value['lastSeen'] != newState['lastSeen']) {
        value = newState;
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
