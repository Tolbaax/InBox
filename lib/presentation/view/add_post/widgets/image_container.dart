import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';

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
              Positioned(
                right: 0.0,
                child: IconButton(
                  splashRadius: 20.0.sp,
                  alignment: AlignmentDirectional.topEnd,
                  onPressed: () => cubit.deletePostImage(),
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
              ),
            ],
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
