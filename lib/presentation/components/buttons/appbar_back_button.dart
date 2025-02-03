import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/app_colors.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        navigatePop(context);
      },
      splashRadius: 20.0.sp,
      splashColor: AppColors.lightBlue.withOpacity(0.38),
      icon: Icon(
        CupertinoIcons.back,
        color: AppColors.black,
        size: 25.0.sp,
      ),
    );
  }
}
