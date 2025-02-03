import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/app_colors.dart';
import 'my_cached_net_image.dart';

class ShowImageWithLongPress extends StatelessWidget {
  final String imageUrl;
  final Widget child;

  const ShowImageWithLongPress(
      {super.key, required this.imageUrl, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return SafeArea(
                  child: Stack(
                    children: [
                      // Blurred background
                      GestureDetector(
                        onTap: () => navigatePop(context),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.5, sigmaY: 2.5),
                          child: Container(
                            color: AppColors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                      // Centered image
                      Center(
                        child: MyCachedNetImage(
                          radius: 110.0.r,
                          imageUrl: imageUrl,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: child,
        ),
      ],
    );
  }
}
