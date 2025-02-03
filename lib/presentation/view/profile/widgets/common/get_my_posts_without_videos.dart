import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';

import '../../../../../domain/entities/post_entity.dart';
import '../../../../components/post_item/post_item.dart';
import '../../../../controllers/post/post_cubit.dart';
import '../../../home/widgets/posts_divider.dart';
import 'tab_view_no_posts_yet.dart';

class GetMyPostsWithoutVideos extends StatelessWidget {
  final String uID;
  final bool tapFromMyProfile, tapFromUserProfile;

  const GetMyPostsWithoutVideos({
    super.key,
    required this.uID,
    required this.tapFromMyProfile,
    required this.tapFromUserProfile,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostEntity>>(
      stream: PostCubit.get(context).getMyPostsWithoutVideos(uID),
      builder: (context, snapshot) {
        return ConditionalBuilder(
          condition: snapshot.hasData,
          builder: (context) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  final lastItem = snapshot.data!.last;
                  return PostItem(
                    post: post,
                    lastItem: lastItem,
                    lastItemHeight: context.height * 0.05,
                    tapFromMyProfile: tapFromMyProfile,
                    tapFromUserProfile: tapFromUserProfile,
                  );
                },
                separatorBuilder: (context, index) {
                  return const PostsDivider();
                },
              );
            } else {
              return const TabViewNoPostsYet();
            }
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(strokeWidth: 2.5.sp),
          ),
        );
      },
    );
  }
}
