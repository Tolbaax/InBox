import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? suffixTap;
  final bool isTextFieldEmpty;
  final String hintText;

  const SearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.suffixTap,
    required this.isTextFieldEmpty,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.0.h,
      child: TextField(
        controller: controller,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.5.sp),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.search,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.flashWhite,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 8.0.h),
          prefixIcon: Icon(
            Icons.search,
            color: controller!.text.isEmpty ? AppColors.gray : AppColors.primary,
          ),
          suffixIcon: isTextFieldEmpty && controller!.text.isNotEmpty
              ? IconButton(
                  onPressed: suffixTap,
                  splashRadius: 10.0.sp,
                  icon: Icon(
                    CupertinoIcons.xmark,
                    size: 16.0.sp,
                    color: AppColors.black,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0.r),
            borderSide: BorderSide(color: AppColors.flashWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0.r),
            borderSide: BorderSide(color: AppColors.flashWhite),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0.r),
            borderSide: BorderSide(color: AppColors.flashWhite),
          ),
        ),
      ),
    );
  }
}
