import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/functions/navigator.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../components/profile_image/my_cached_net_image.dart';
import '../../../controllers/user/user_cubit.dart';
import '../../../controllers/user/user_states.dart';
import '../widgets/edit_profile/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = UserCubit.get(context);
    final user = cubit.userEntity;

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) async {
        if (state is UpdateUserDataSuccessState) {
          navigatePop(context);
          await cubit.getCurrentUser();
          cubit.profileImageFile = null;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(color: AppColors.blackOlive),
            title: const Text(AppStrings.editProfile),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                MyCachedNetImage(
                  onTap: () => cubit.selectProfileImageFromGallery(context),
                  imageUrl: user!.profilePic,
                  radius: 55.0.sp,
                  haveButton: true,
                  imageFile: cubit.profileImageFile,
                ),
                SizedBox(
                  height: 35.0.h,
                ),
                const EditProfileForm(),
              ],
            ),
          ),
        );
      },
    );
  }
}
