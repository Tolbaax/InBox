import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../../../../../core/injection/injector.dart';
import '../common/statistics_column.dart';

class UserProfileStatistics extends StatelessWidget {
  final String uID;

  const UserProfileStatistics({super.key, required this.uID});

  @override
  Widget build(BuildContext context) {
    final firestore = sl<FirebaseFirestore>();

    final snapshot = firestore.collection('users').doc(uID).snapshots();

    return StreamBuilder(
      stream: snapshot,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;

        final userData = snapshot.data?.data();

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 25.0.sp, bottom: 10.0.sp),
          child: Row(
            children: [
              StatisticsColumn(
                number: isLoading ? 0 : userData?['postsCount'] ?? 0,
                text: AppStrings.posts,
              ),
              SizedBox(width: 23.0.w),
              StatisticsColumn(
                number: isLoading ? 0 : userData?['followers']?.length ?? 0,
                text: AppStrings.followers,
              ),
              SizedBox(width: 23.0.w),
              StatisticsColumn(
                number: isLoading ? 0 : userData?['following']?.length ?? 0,
                text: AppStrings.following,
              ),
            ],
          ),
        );
      },
    );

  }
}
