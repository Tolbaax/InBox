import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/app_colors.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CustomCachedNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorWidget(),
      fit: BoxFit.cover,
      fadeOutDuration: const Duration(seconds: 1),
      fadeInDuration: const Duration(seconds: 2),
    );
  }

  Widget _buildPlaceholder() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.gray.withOpacity(0.3),
          ),
        ),
        SpinKitPulse(color: AppColors.primary.withOpacity(0.5)),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.gray.withOpacity(0.3),
      ),
    );
  }
}
