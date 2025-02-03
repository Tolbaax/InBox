import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import '../../../../../../core/functions/app_dialogs.dart';
import '../../../../../../core/functions/validators.dart';
import '../../../../../../core/params/auth/user_params.dart';
import '../../../../../../core/shared/common.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text_fields/custom_text_field.dart';
import '../../../../controllers/user/user_cubit.dart';
import '../../../../controllers/user/user_states.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = UserCubit.get(context);
    var user = cubit.userEntity;
    final formKey = GlobalKey<FormState>();
    bool isUsernameTaken = false;
    cubit.nameController.text = user!.name.toString();
    cubit.bioController.text = user.bio.toString();
    cubit.userNameController.text = user.username.toString().toLowerCase();

    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        final userCubit = UserCubit.get(context);

        return Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 18.0.sp),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: cubit.nameController,
                  hintText: AppStrings.name,
                  labelText: AppStrings.name,
                  validator: (value) => Validators.validateName(value),
                ),
                SizedBox(
                  height: 22.0.h,
                ),
                CustomTextField(
                  controller: cubit.userNameController,
                  hintText: AppStrings.userName,
                  keyboardType: TextInputType.emailAddress,
                  labelText: AppStrings.userName,
                  onChanged: (value) async {
                    isUsernameTaken = await checkUsernameAvailability(value);
                  },
                  validator: (value) => Validators.validateUsername(value,
                      isUsernameTaken: isUsernameTaken),
                ),
                SizedBox(
                  height: 22.0.h,
                ),
                CustomTextField(
                  controller: cubit.bioController,
                  hintText: AppStrings.bio,
                  labelText: AppStrings.bio,
                  keyboardType: TextInputType.multiline,
                  maxLength: 150,
                ),
                SizedBox(height: context.height * 0.2),
                SizedBox(
                  width: context.width * 0.6,
                  child: CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (await checkInternetConnectivity()) {
                          userCubit.updateUserData(
                            UserParams(
                              username: cubit.userNameController.text,
                              name: cubit.nameController.text,
                              bio: cubit.bioController.text,
                              profileUrl: cubit.profileImageFile != null
                                  ? cubit.profileImageFile!.path
                                  : '',
                            ),
                          );
                        } else {
                          AppDialogs.showToast(
                              msg: AppStrings.noInternetAccess);
                        }
                      }
                    },
                    text: AppStrings.save,
                    condition: state is UpdateUserDataLoadingState,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
