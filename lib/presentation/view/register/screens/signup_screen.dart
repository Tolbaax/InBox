import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/functions/navigator.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../core/injection/injector.dart';
import '../../../controllers/auth/auth_cubit.dart';
import '../../../controllers/auth/auth_states.dart';
import '../widgets/register_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) async {
          if (state is RegisterSuccessfullyState) {
            navigateAndRemove(context, Routes.login);
            context.read<AuthCubit>().clearSignUpControllers();
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 20.0.w,
                  end: 20.0.w,
                  top: 40.0.h,
                ),
                child: Column(
                  children: [
                    SafeArea(
                      child: Image.asset(
                        ImgAssets.logo,
                        height: 70.h,
                      ),
                    ),
                    SizedBox(
                      height: 15.0.h,
                    ),
                    Text(
                      AppStrings.signUp,
                      style: TextStyle(
                        fontSize: 33.0.sp,
                        color: AppColors.primary,
                        letterSpacing: 4.5.sp,
                        fontFamily: AppStrings.economicaFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40.0.h,
                    ),
                    RegisterForm(cubit: cubit, state: state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
