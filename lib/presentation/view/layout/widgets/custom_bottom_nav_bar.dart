import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../controllers/layout/layout_cubit.dart';
import 'bottom_nav_item.dart';

class CustomBottomNavBar extends StatefulWidget {
  final LayoutCubit cubit;

  const CustomBottomNavBar({super.key, required this.cubit});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation borderRadiusCurve;

  @override
  void initState() {
    super.initState();

    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    Future.delayed(
      const Duration(milliseconds: 500),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: Constants.iconList.length,
      tabBuilder: (int index, bool isActive) {
        return BottomNavItem(index: index, isActive: isActive);
      },
      backgroundColor: AppColors.white,
      activeIndex: widget.cubit.selectedIndex,
      splashColor: AppColors.primary,
      notchAndCornersAnimation: borderRadiusAnimation,
      splashSpeedInMilliseconds: 0,
      notchSmoothness: NotchSmoothness.softEdge,
      gapLocation: GapLocation.center,
      rightCornerRadius: 20.sp,
      leftCornerRadius: 20.sp,
      onTap: (index) => widget.cubit.changeBottomNav(index),
      shadow: BoxShadow(
        offset: const Offset(0, 1),
        blurRadius: 0.65,
        spreadRadius: 0.4,
        color: AppColors.primary,
      ),
    );
  }
}
