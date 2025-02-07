import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/constants.dart';
import '../../../components/profile_image/my_cached_net_image.dart';

class ShimmerUserCard extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const ShimmerUserCard({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (!snapshot.hasData || snapshot.data == null) {
      return buildShimmerRow(context);
    }

    return ListView.separated(
      itemCount: snapshot.data!.docs != null && snapshot.data!.docs.length > 5
          ? 5
          : snapshot.data!.docs.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 8.0.h);
      },
      itemBuilder: (context, index) {
        return buildShimmerRow(context);
      },
    );
  }

  Widget buildShimmerRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          gradient: Constants.shimmerGradient,
          child: MyCachedNetImage(
            imageUrl: '',
            radius: 28.0.sp,
          ),
        ),
        SizedBox(
          width: 10.0.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.5.h,
            ),
            Shimmer(
              gradient: Constants.shimmerGradient,
              child: SizedBox(
                width: context.width * 0.45,
                height: context.height * 0.0128,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5.0.sp),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7.0.h,
            ),
            Shimmer(
              gradient: Constants.shimmerGradient,
              child: SizedBox(
                width: context.width * 0.3,
                height: context.height * 0.0128,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5.0.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
