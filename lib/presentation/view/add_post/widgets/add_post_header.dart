import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/presentation/view/add_post/widgets/gif_container.dart';
import '../../../../core/injection/injector.dart';
import '../../../components/profile_image/my_cached_net_image.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';
import '../../../controllers/post/add_post/add_post_states.dart';
import '../../../controllers/user/user_cubit.dart';
import 'add_post_text_filed.dart';
import 'image_container.dart';
import 'video_container.dart';

class AddPostHeader extends StatelessWidget {
  const AddPostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final user = sl<UserCubit>().userEntity;
    final cubit = context.read<AddPostCubit>();

    return BlocConsumer<AddPostCubit, AddPostStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(bottom: context.height * 0.12),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15.0.sp),
                child: Form(
                  key: formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCachedNetImage(
                        imageUrl: user!.profilePic,
                        radius: 22.5.sp,
                      ),
                      SizedBox(
                        width: 10.0.w,
                      ),
                      const AddPostTextFiled(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              ImageContainer(cubit: cubit),
              VideoContainer(cubit: cubit),
              GifContainer(cubit: cubit),
            ],
          ),
        );
      },
    );
  }
}
