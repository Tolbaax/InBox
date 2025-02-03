import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:inbox/domain/entities/user_entity.dart';

import '../common/statistics_column.dart';

class UserProfileStatistics extends StatelessWidget {
  final UserEntity user;

  const UserProfileStatistics({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final snapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uID)
        .snapshots();

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

        final userData = snapshot.data!.data();
        return Padding(
          padding: EdgeInsetsDirectional.only(start: 25.0.sp, bottom: 10.0.sp),
          child: Row(
            children: [
              StatisticsColumn(
                number: userData!['postsCount'],
                text: AppStrings.posts,
              ),
              SizedBox(
                width: 23.5.w,
              ),
              StatisticsColumn(
                number: userData['followers'].length,
                text: AppStrings.followers,
              ),
              SizedBox(
                width: 23.5.w,
              ),
              StatisticsColumn(
                number: userData['following'].length,
                text: AppStrings.following,
              ),
            ],
          ),
        );
      },
    );
  }
}
