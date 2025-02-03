import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:inbox/core/utils/assets_manager.dart';
import 'package:lottie/lottie.dart';

class NoInternetIcon extends StatelessWidget {
  const NoInternetIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Lottie.asset(ImgAssets.noInternet),
          Positioned(
            bottom: 0.0,
            child: Text(
              AppStrings.checkInternet,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0.sp,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
