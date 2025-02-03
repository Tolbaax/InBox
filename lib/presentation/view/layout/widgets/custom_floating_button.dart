import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/utils/app_colors.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({super.key});

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1100),
      );
    }

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CircularRevealAnimation(
      animation: _animation,
      child: GestureDetector(
        onTap: () => navigateTo(context, Routes.addPost),
        child: CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 24.0.sp,
          child: Icon(
            FontAwesomeIcons.plus,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
