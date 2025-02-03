import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../common/statistics_column.dart';

class MyProfileStatistics extends StatelessWidget {
  final UserEntity user;

  const MyProfileStatistics({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 25.0.sp, bottom: 10.0.sp),
      child: Row(
        children: [
          StatisticsColumn(
            number: user.postsCount,
            text: AppStrings.posts,
          ),
          SizedBox(
            width: 23.5.w,
          ),
          StatisticsColumn(
            number: user.followers.length,
            text: AppStrings.followers,
          ),
          SizedBox(
            width: 23.5.w,
          ),
          StatisticsColumn(
            number: user.following.length,
            text: AppStrings.following,
          ),
        ],
      ),
    );
  }
}
