import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/functions/navigator.dart';
import '../../../../../core/utils/app_strings.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.haveAccount,
          style: TextStyle(fontSize: 14.0.sp),
        ),
        TextButton(
          style: ButtonStyle(
            alignment: AlignmentDirectional.centerStart,
            padding: WidgetStateProperty.all(
              EdgeInsetsDirectional.only(start: 3.5.w),
            ),
          ),
          onPressed: () {
            navigatePop(context);
          },
          child: Text(
            AppStrings.login,
            style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
