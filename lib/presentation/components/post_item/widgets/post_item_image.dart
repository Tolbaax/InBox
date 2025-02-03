import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../common/custom_cached_network_image.dart';

class PostItemImage extends StatelessWidget {
  final String imageUrl;
  final bool isGif;

  const PostItemImage({super.key, required this.imageUrl, required this.isGif});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 5.h, start: 10.w, end: 10.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.sp),
          //TODO: Handle AspectRatio && Send Image Ratio In PostModel
          child: isGif
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: context.height * 0.40,
                    minWidth: context.width,
                  ),
                  child: CustomCachedNetworkImage(imageUrl: imageUrl),
                )
              : AspectRatio(
                  aspectRatio: 1 / 1,
                  child: CustomCachedNetworkImage(imageUrl: imageUrl),
                ),
        ),
      ),
    );
  }
}
