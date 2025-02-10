import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer {
  /// Shimmer for Text Placeholder
  static Shimmer shimmerText({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );
  }
}
