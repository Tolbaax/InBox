import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
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
          cubit.disposeProfileImage();
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            await _onPopInvokedWithResult(context, cubit, didPop, user);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(color: AppColors.blackOlive),
              title: const Text(AppStrings.editProfile),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  MyCachedNetImage(
                    onTap: () => cubit.selectProfileImageFromGallery(context),
                    imageUrl: user?.profilePic ?? '',
                    radius: 55.0.sp,
                    haveButton: true,
                    imageFile: cubit.profileImageFile,
                  ),
                  SizedBox(height: 35.0.h),
                  const EditProfileForm(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onPopInvokedWithResult(
    BuildContext context,
    UserCubit cubit,
    bool didPop,
    var user,
  ) async {
    if (didPop) return;

    bool hasChanges = cubit.profileImageFile != null ||
        cubit.nameController.text != user.name ||
        cubit.userNameController.text != user.username ||
        cubit.bioController.text != user.bio;

    if (hasChanges) {
      AppDialogs.showDiscardEditProfileDialog(context, cubit);
    } else {
      navigatePop(context);
    }
  }
}
