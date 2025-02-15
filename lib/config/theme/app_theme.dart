import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

ThemeData appTheme() {
  // Lock the screen orientation to landscape
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  _setSystemUIOverlayStyle();

  return ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    fontFamily: AppStrings.montserratFont,
    scaffoldBackgroundColor: Colors.white,
    dividerColor: AppColors.primary.withOpacity(0.4),
    appBarTheme: _appBarTheme(),
    progressIndicatorTheme: _progressIndicatorTheme(),
    popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
    textTheme: const TextTheme(),
    listTileTheme: _listTileTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomSheetTheme: _bottomSheetTheme(),
    tabBarTheme: _tabBarTheme(),
  );
}

void _setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
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
  );
}

ProgressIndicatorThemeData _progressIndicatorTheme() {
  return ProgressIndicatorThemeData(color: AppColors.primary);
}

ListTileThemeData _listTileTheme() {
  return ListTileThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1.sp, color: AppColors.flashWhite),
      borderRadius: BorderRadius.circular(15.sp),
    ),
    horizontalTitleGap: 14.0.w,
    minLeadingWidth: 0.0,
  );
}

BottomSheetThemeData _bottomSheetTheme() {
  return const BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 0.0,
  );
}

TabBarTheme _tabBarTheme() {
  return TabBarTheme(
    unselectedLabelColor: AppColors.grayRegular,
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: AppColors.black,
    indicatorColor: AppColors.black,
  );
}
