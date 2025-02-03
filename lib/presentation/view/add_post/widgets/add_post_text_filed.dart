import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/validators.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';

class AddPostTextFiled extends StatelessWidget {
  const AddPostTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddPostCubit.get(context).postTextController;
    return SizedBox(
      width: context.width * 0.74,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 15.0.sp,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: AppStrings.whatsOnYourMind,
          hintStyle: TextStyle(
            fontSize: 17.5.sp,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
        validator: (value) => Validators.validatePostText(value!),
      ),
    );
  }
}
