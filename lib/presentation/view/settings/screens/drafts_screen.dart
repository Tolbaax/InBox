import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../../../../core/injection/injector.dart';
import '../../../../domain/entities/post_entity.dart';
import '../../../components/post_item/post_item.dart';
import '../../../controllers/post/post_cubit.dart';
import '../../../controllers/post/post_states.dart';
import '../../home/widgets/posts_divider.dart';
import '../widgets/no_saved_posts_yet.dart';

class DraftsScreen extends StatelessWidget {
  const DraftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postsCubit = sl<PostCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.blackOlive),
        title: const Text(AppStrings.savedPosts),
      ),
      body: BlocProvider(
        create: (BuildContext context) => postsCubit,
        child: BlocConsumer<PostCubit, PostStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return StreamBuilder<List<PostEntity>>(
              stream: postsCubit.getSavedPosts(),
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
                            lastItemHeight: context.height * 0.1,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const PostsDivider();
                        },
                      );
                    } else {
                      return const NoSavedPostsYet();
                    }
                  },
                  fallback: (context) => Center(
                    child: snapshot.hasError
                        ? const NoSavedPostsYet()
                        : const CircularProgressIndicator(strokeWidth: 1.2),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
