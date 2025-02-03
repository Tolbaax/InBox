import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:inbox/core/services/injection_container.dart' as di;

import '../../../data/datasources/auth/local/auth_local_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1350),
    vsync: this,
  );

  late final Animation<double> _animation =
      Tween<double>(begin: 0, end: 1.3).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ),
  );

  void _goNext() => di.sl<AuthLocalDataSource>().getUser() != null &&
          FirebaseAuth.instance.currentUser != null
      ? navigateAndReplace(context, Routes.layout)
      : navigateAndReplace(context, Routes.login);

  void _startTimer() {
    Timer(const Duration(milliseconds: 1350), _goNext);
  }

  @override
  void initState() {
    super.initState();
    _controller.forward().then((value) => _startTimer());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: context.height * 0.15),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ScaleTransition(
                  scale: _animation,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    ImgAssets.logo,
                    height: 120.h,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: context.height * 0.1),
              // Adjust the bottom padding as needed
              child: Text(
                AppStrings.appName,
                style: TextStyle(
                  fontFamily: AppStrings.guyonGazeboFont,
                  fontSize: 45.0.sp,
                  color: AppColors.primary,
                  letterSpacing: 3.5.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
