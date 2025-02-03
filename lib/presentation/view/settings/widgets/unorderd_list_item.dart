import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';

class UnorderedListItem extends StatelessWidget {
  final String text;

  const UnorderedListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: context.width * 0.11, bottom: 10.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "• ",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.grayRegular,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.grayRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
