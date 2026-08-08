import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../view/home/widgets/posts_divider.dart';

enum PostShimmerType { textOnly, imageOnly, textWithImage }

class PostItemShimmer extends StatelessWidget {
  final PostShimmerType type;
  final double? imageHeight;

  const PostItemShimmer({
    super.key,
    required this.type,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.all(7.5.sp), // Same as PostItem
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header shimmer (always present)
            _buildHeaderShimmer(context),

            // Text shimmer (only for text types)
            if (type == PostShimmerType.textOnly ||
                type == PostShimmerType.textWithImage)
              _buildTextShimmer(context),

            // Image shimmer (only for image types)
            if (type == PostShimmerType.imageOnly ||
                type == PostShimmerType.textWithImage)
              _buildMediaShimmer(context),

            // Actions shimmer (always present)
            _buildActionsShimmer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture - exact same as PostItemHeader
            CircleAvatar(
              radius: 22.0,
              backgroundColor: Colors.grey[300],
              child: CircleAvatar(
                radius: 18.5.sp,
                backgroundColor: Colors.grey[400],
              ),
            ),
            SizedBox(width: 6.5.w),

            // Name and time column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name container
                Container(
                  constraints: BoxConstraints(
                    maxWidth: context.width * 0.7,
                  ),
                  child: Container(
                    height: 10.0.sp,
                    width: context.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.sp),
                    ),
                  ),
                ),
                SizedBox(height: 6.sp),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: context.width * 0.7,
                      ),
                      child: Container(
                        height: 10.5.sp,
                        width: context.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 3.5.sp,
                        end: 2.5.sp,
                      ),
                      child: CircleAvatar(
                        radius: 1.2.sp,
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    Container(
                      height: 9.5.sp,
                      width: 9.5.sp,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(7.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Menu button - positioned same as original
        Positioned(
          top: 2.5.sp,
          right: 5.0.sp,
          child: Container(
            height: 8.0.sp,
            width: 23.0.sp,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextShimmer(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 13.5.sp,
            width: context.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.sp),
            ),
          ),
          SizedBox(height: 4.sp),
          Container(
            height: 13.5.sp,
            width: context.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.sp),
            ),
          ),
          SizedBox(height: 4.sp),
          Container(
            height: 13.5.sp,
            width: context.width * 0.6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaShimmer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.sp),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: context.height * 0.40,
            maxWidth: context.width,
          ),
          child: Container(
            height: imageHeight ?? 180.h,
            width: context.width,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget _buildActionsShimmer(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: context.width * 0.04,
        end: context.width * 0.04,
      ),
      child: Column(
        children: [
          Divider(color: Colors.grey.withValues(alpha: 0.4)),

          // Action buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButtonShimmer(),
              _buildActionButtonShimmer(),
              _buildActionButtonShimmer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonShimmer() {
    return Container(
      height: 18.sp,
      width: 70.sp,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6.sp),
      ),
    );
  }
}

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // Define different shimmer variations
    final shimmerVariations = [
      PostItemShimmer(
        type: PostShimmerType.imageOnly,
        imageHeight: context.height * 0.25,
      ),
      const PostItemShimmer(
        type: PostShimmerType.textOnly,
      ),
      PostItemShimmer(
        type: PostShimmerType.imageOnly,
        imageHeight: context.height * 0.25,
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      itemCount: shimmerVariations.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return shimmerVariations[index];
      },
      separatorBuilder: (context, index) {
        return const PostsDivider();
      },
    );
  }
}
