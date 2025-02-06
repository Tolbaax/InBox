import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';
import 'cancel_post_icon.dart';

class ImageContainer extends StatelessWidget {
  final AddPostCubit cubit;

  const ImageContainer({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (cubit.postImage != null)
          Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: context.height * 0.44,
                  maxHeight: context.height * 0.44,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0.sp),
                  border: Border.all(color: AppColors.gray),
                  image: DecorationImage(
                    image: FileImage(cubit.postImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              CancelPostIcon(onPressed: () => cubit.disposePostImage()),
            ],
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
