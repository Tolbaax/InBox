import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

ThemeData appTheme() {
  // Set the status bar color to white
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  return ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    fontFamily: AppStrings.montserratFont,
    scaffoldBackgroundColor: Colors.white,
    dividerColor: AppColors.primary.withOpacity(0.4),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 18.5.sp,
        fontFamily: AppStrings.montserratFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5.sp,
      ),
    ),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: AppColors.primary),
    popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
    textTheme: const TextTheme(),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.sp, color: AppColors.flashWhite),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      horizontalTitleGap: 14.0.w,
      minLeadingWidth: 0.0,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: AppColors.gray,
      labelColor: AppColors.black,
    ),
  );
}
