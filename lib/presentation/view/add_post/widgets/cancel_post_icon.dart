import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils/app_colors.dart';

class CancelPostIcon extends StatelessWidget {
  final void Function() onPressed;

  const CancelPostIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0.0,
      top: 0.0,
      child: IconButton(
        splashRadius: 20.0.sp,
        alignment: AlignmentDirectional.topEnd,
        onPressed: onPressed,
        icon: Icon(
          FontAwesomeIcons.xmark,
          color: AppColors.white,
          shadows: [
            BoxShadow(
              color: AppColors.black,
              spreadRadius: 1.sp,
              blurRadius: 5.sp,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
