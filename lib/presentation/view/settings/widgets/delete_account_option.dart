import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import 'settings_option.dart';

class DeleteAccountOption extends StatelessWidget {
  const DeleteAccountOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.dangerousArea,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5.sp),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        SettingsOption(
          onTap: () => navigateTo(context, Routes.deleteAccount),
          icon: FontAwesomeIcons.trashCan,
          title: AppStrings.deleteAccount,
          bottom: 8.0.h,
          titleColor: AppColors.red.withOpacity(0.8),
          leadingColor: AppColors.red.withOpacity(0.6),
          trailingColor: AppColors.red.withOpacity(0.6),
        ),
        Text(
          AppStrings.ifDeleteAccountNow,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.grayRegular,
          ),
        ),
      ],
    );
  }
}
