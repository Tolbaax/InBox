import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/shared/common.dart';
import 'package:inbox/domain/entities/user_entity.dart';
import 'package:readmore/readmore.dart';
import '../../../../../../core/utils/app_colors.dart';

class NameAndBio extends StatelessWidget {
  final UserEntity user;

  const NameAndBio({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: context.width * 0.85,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              user.name,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 15.4.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0.h,
        ),
        if (user.bio.isNotEmpty)
          ReadMoreText(
            removeEmptyLines(user.bio),
            trimLines: 4,
            trimMode: TrimMode.Line,
            moreStyle: TextStyle(
              fontSize: 13.0.sp,
              color: AppColors.primary,
            ),
            lessStyle: TextStyle(
              fontSize: 13.0.sp,
              color: AppColors.primary,
            ),
            trimCollapsedText: 'more',
            trimExpandedText: ' ',
            style: TextStyle(
              color: AppColors.black,
              height: 1.25.sp,
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
