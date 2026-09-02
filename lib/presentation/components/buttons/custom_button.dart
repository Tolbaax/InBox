import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String text;
  final bool? condition;
  final List<Color>? colors;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.condition = false,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoading = condition ?? false;
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: context.width * 0.8,
          maxWidth: context.width * 0.9,
          minHeight: 40.0.h,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors ??
                  [
                    AppColors.primary,
                    AppColors.primary,
                    AppColors.lightBlue,
                  ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20.0.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.5),
                blurRadius: 3.0.sp,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 1.2),
                  )
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
