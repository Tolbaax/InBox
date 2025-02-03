import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputAction? textInputAction;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? suffixTab;
  final bool obscureText;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final double? verticalPadding;
  final AutovalidateMode? autoValidateMode;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.textInputAction,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixTab,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.autofillHints,
    this.verticalPadding,
    this.autoValidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLines: keyboardType == TextInputType.multiline ? 6 : 1,
      minLines: 1,
      maxLength: maxLength,
      autofillHints: autofillHints,
      autovalidateMode: autoValidateMode,
      style: const TextStyle(fontWeight: FontWeight.w500),
      // onTapOutside: (event) {
      //   FocusManager.instance.primaryFocus!.unfocus();
      // },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        labelText: labelText,
        contentPadding: EdgeInsetsDirectional.symmetric(
          vertical: verticalPadding ?? 12.0.sp,
          horizontal: 16.0.sp,
        ),
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.black.withOpacity(0.35),
                size: 17.5.sp,
              )
            : null,
        suffixIcon: (suffixIcon != null)
            ? GestureDetector(
                onTap: suffixTab,
                child: Icon(
                  suffixIcon,
                  color: AppColors.black.withOpacity(0.4),
                  size: 21.0.sp,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0.r),
          borderSide: BorderSide(color: AppColors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0.r),
          borderSide: BorderSide(color: AppColors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0.r),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0.r),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0.r),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
