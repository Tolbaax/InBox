import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../controllers/post/comment/comment_cubit.dart';
import '../../../controllers/post/comment/comment_states.dart';
import 'widgets/comment_card.dart';
import 'widgets/comment_filed.dart';
import 'widgets/no_comments_yet.dart';

class CommentScreen extends StatelessWidget {
  final String postID;

  const CommentScreen({super.key, required this.postID});

  @override
  Widget build(BuildContext context) {
    final CommentCubit commentCubit = sl<CommentCubit>()..getComments(postID);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.black),
        title: const Text(AppStrings.comments),
      ),
      body: BlocConsumer<CommentCubit, CommentStates>(
        bloc: commentCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetCommentsLoadingState) {
            return Center(
                child: CircularProgressIndicator(strokeWidth: 2.5.sp));
          }

          if (state is GetCommentsSuccessState) {
            if (state.comments.isEmpty) {
              return const Center(child: NoCommentsYet());
            } else {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];
                  final lastItem = state.comments.last;
                  return CommentCard(comment: comment, lastItem: lastItem);
                },
                separatorBuilder: (context, state) {
                  return SizedBox(height: 10.0.h);
                },
              );
            }
          }

          return const SizedBox.shrink();
        },
      ),
      bottomSheet: CommentFiled(postID: postID),
    );
  }
}
