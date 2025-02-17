import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/domain/entities/post_entity.dart';
import 'package:inbox/presentation/controllers/post/post_states.dart';
import '../../../../core/injection/injector.dart';
import '../../../components/post_item/post_item.dart';
import '../../../controllers/post/post_cubit.dart';
import '../widgets/home_appbar.dart';
import '../widgets/no_posts_yet.dart';
import '../widgets/posts_divider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postsCubit = sl<PostCubit>();

    return Scaffold(
      appBar: const HomeAppBar(),
      body: BlocProvider.value(
        value: sl<PostCubit>(),
        child: BlocConsumer<PostCubit, PostStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return StreamBuilder<List<PostEntity>>(
              stream: postsCubit.getPosts(),
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
                            lastItemHeight: context.height * 0.075,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const PostsDivider();
                        },
                      );
                    } else {
                      return const NoPotsYet();
                    }
                  },
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 1.2),
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
