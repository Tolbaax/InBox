import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';

class GifContainer extends StatelessWidget {
  final AddPostCubit cubit;

  const GifContainer({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (cubit.gif != null)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(10.0.sp),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: context.height * 0.45,
                    maxWidth: context.width * 0.85,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: cubit.gifUrl ?? '',
                    maxHeightDiskCache: 390,
                    errorWidget: (context, url, error) {
                      return SizedBox(
                        height: 130.0.sp,
                        width: 180.0.sp,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            size: 35.0.sp,
                            color: AppColors.black,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      return SizedBox(
                        height: 110.0.sp,
                        width: 160.0.sp,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2.0.sp),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0.0,
                child: IconButton(
                  splashRadius: 20.0.sp,
                  alignment: AlignmentDirectional.topEnd,
                  onPressed: () => cubit.disposeGif(),
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
