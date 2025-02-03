import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constants.dart';

class BottomNavItem extends StatelessWidget {
  final int index;
  final bool isActive;

  const BottomNavItem({super.key, required this.index, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final orientation =
        MediaQuery.of(context).orientation; // Get current orientation

    final fontWeight = isActive ? FontWeight.w600 : FontWeight.w500;
    final color =
        isActive ? AppColors.primary : AppColors.black.withOpacity(0.5);

    double iconSize = isActive ? 18.0.sp : 16.5.sp;

    // Conditionally adjust icon size for landscape orientation
    if (orientation == Orientation.landscape) {
      iconSize *= 0.75;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: index == 0 ? 4.5.w : 0.0),
          child: Icon(
            Constants.iconList[index],
            size: iconSize,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          Constants.titles[index],
          maxLines: 1,
          style: TextStyle(color: color, fontWeight: fontWeight),
        )
      ],
    );
  }
}
