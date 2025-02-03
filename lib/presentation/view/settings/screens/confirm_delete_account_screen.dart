import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../components/buttons/appbar_back_button.dart';
import '../../../controllers/user/user_cubit.dart';
import '../../../controllers/user/user_states.dart';

class ConfirmDeleteAccountScreen extends StatelessWidget {
  const ConfirmDeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is DeleteUserAccountSuccessState) {
          navigateAndRemove(context, Routes.login);
        }
      },
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        var user = cubit.userEntity;

        return Scaffold(
          appBar: AppBar(
            leading: const AppBarBackButton(),
            title: const Text(AppStrings.deleteThisAccount),
          ),
          body: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: context.width * 0.9),
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.05),
                  CircleAvatar(
                    radius: 62.0.r,
                    backgroundColor: AppColors.red.withOpacity(0.14),
                    child: Icon(
                      FontAwesomeIcons.triangleExclamation,
                      color: AppColors.red,
                      size: 50.0.sp,
                    ),
                  ),
                  SizedBox(height: context.height * 0.025),
                  Text(
                    user?.username ?? '', // Check for null user
                    style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: context.height * 0.008),
                  Text(
                    AppStrings.deleteProceed,
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: context.height * 0.018),
                  Text(
                    AppStrings.deleteInBox,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await cubit.deleteUserAccount();
                    },
                    child: Container(
                      height: 35.0.h,
                      width: context.width * 0.45,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(20.0.r),
                      ),
                      child: Center(
                        child: state is DeleteUserAccountLoadingState
                            ? CircularProgressIndicator(
                                color: AppColors.white, strokeWidth: 2.5.sp)
                            : Center(
                                child: Text(
                                  AppStrings.deleteAccount,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 13.2.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height * 0.075),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
