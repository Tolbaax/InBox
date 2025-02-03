import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../text_fields/custom_text_field.dart';
import '../../../../controllers/post/comment/comment_cubit.dart';

class CommentFiled extends StatelessWidget {
  final String postID;

  const CommentFiled({super.key, required this.postID});

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final cubit = CommentCubit.get(context);

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            bottom: 10.0.h, end: 12.0.sp, start: 12.0.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                controller: commentController,
                hintText: AppStrings.writeComment,
                keyboardType: TextInputType.multiline,
                verticalPadding: 3.0,
              ),
            ),
            SizedBox(
              width: 8.0.w,
            ),
            GestureDetector(
              onTap: () async {
                if (commentController.text.trim().isNotEmpty) {
                  cubit.addComment(postID, commentController.text.trim());
                  commentController.clear();
                }
              },
              child: CircleAvatar(
                radius: 22.0.sp,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20.0.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
