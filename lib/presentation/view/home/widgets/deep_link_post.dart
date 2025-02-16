import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:inbox/presentation/components/post_item/post_item.dart';
import 'package:inbox/presentation/controllers/post/post_cubit.dart';
import '../../../../core/injection/injector.dart';
import '../../../../core/utils/app_colors.dart';

class DeepLinkPostScreen extends StatelessWidget {
  final String postID;

  const DeepLinkPostScreen({super.key, required this.postID});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<PostCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: false,
        title: Text(
          AppStrings.appName,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 25.0.sp,
            letterSpacing: 1.0.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: cubit.getPostByPostID(postID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 1.2));
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error loading post'));
          }

          final post = snapshot.data!;
          return PostItem(post: post, lastItem: post, lastItemHeight: 0);
        },
      ),
    );
  }
}
