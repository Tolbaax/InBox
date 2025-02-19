import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        leadingWidth: context.width * 0.275,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Text(
            AppStrings.appName,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 25.0.sp,
              letterSpacing: 1.0.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Badge.count(
            count: 12,
            offset: const Offset(-8, 7),
            backgroundColor: AppColors.red,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bell,
                color: AppColors.blackOlive,
                size: 25.0.sp,
              ),
            ),
          ),
          SizedBox(width: 7.w),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
