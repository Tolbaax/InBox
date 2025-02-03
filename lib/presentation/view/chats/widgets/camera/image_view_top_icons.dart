import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/functions/navigator.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../controllers/chat/chat_cubit.dart';

class ImageViewTopRowIcons extends StatelessWidget {
  final VoidCallback onCropButtonTaped;

  const ImageViewTopRowIcons({super.key, required this.onCropButtonTaped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 4.0.w),
      child: Row(
        children: [
          IconButton(
            splashRadius: 20,
            iconSize: 25.0.sp,
            onPressed: () {
              ChatCubit.get(context).messageImage = null;
              navigatePop(context);
            },
            icon: CircleAvatar(
              radius: 30.0.sp,
              backgroundColor: AppColors.black.withOpacity(0.5),
              child: Icon(Icons.clear, color: AppColors.white),
            ),
          ),
          const Spacer(),
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            icon: const Icon(
              Icons.crop_rotate,
              size: 27,
            ),
            onPressed: onCropButtonTaped,
          ),
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            splashColor: Colors.black38,
            icon: const Icon(
              Icons.edit,
              size: 27,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
