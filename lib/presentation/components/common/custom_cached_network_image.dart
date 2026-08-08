import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class CustomCachedNetworkImage extends StatefulWidget {
  final String imageUrl;

  const CustomCachedNetworkImage({super.key, required this.imageUrl});

  @override
  State<CustomCachedNetworkImage> createState() =>
      _CustomCachedNetworkImageState();
}

class _CustomCachedNetworkImageState extends State<CustomCachedNetworkImage> {
  double? aspectRatio;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrl.isNotEmpty && Uri.tryParse(widget.imageUrl) != null) {
      _getImageAspectRatio();
    } else {
      setState(() {
        isLoading = false;
        aspectRatio = null;
      });
    }
  }

  Future<void> _getImageAspectRatio() async {
    try {
      final image = NetworkImage(widget.imageUrl);
      final imageStream = image.resolve(const ImageConfiguration());

      imageStream.addListener(ImageStreamListener(
        (ImageInfo info, bool _) {
          if (mounted) {
            setState(() {
              aspectRatio = info.image.width / info.image.height;
              isLoading = false;
            });
          }
        },
        onError: (exception, stackTrace) {
          if (mounted) {
            setState(() {
              isLoading = false;
              aspectRatio = null;
            });
          }
        },
      ));
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          aspectRatio = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildPlaceholder();
    }

    return aspectRatio != null
        ? AspectRatio(
            aspectRatio: aspectRatio!,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              placeholder: (context, url) => _buildPlaceholder(),
              errorWidget: (context, url, error) => _buildErrorWidget(),
              fit: BoxFit.cover,
              fadeOutDuration: const Duration(seconds: 1),
              fadeInDuration: const Duration(seconds: 2),
            ),
          )
        : _buildErrorWidget(); // Show error if no aspect ratio could be determined
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: 200.h, // Default height while loading
      decoration: BoxDecoration(
        color: AppColors.gray.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Center(
        child: SpinKitPulse(color: AppColors.primary.withValues(alpha: 0.5)),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: AppColors.gray.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Center(
        child: Icon(Icons.error, size: 35.sp, color: AppColors.gray),
      ),
    );
  }
}
