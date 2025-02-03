import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/functions/validators.dart';
import 'package:inbox/core/shared/common.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../components/buttons/custom_button.dart';
import '../../../components/text_fields/custom_text_field.dart';
import '../../../controllers/auth/auth_cubit.dart';
import '../../../controllers/auth/auth_states.dart';
import 'dont_have_account.dart';

class LoginForm extends StatelessWidget {
  final AuthCubit cubit;
  final AuthStates state;

  const LoginForm({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final formKey1 = GlobalKey<FormState>();

    return Form(
      key: formKey1,
      child: Column(
        children: [
          CustomTextField(
            controller: cubit.emailController,
            hintText: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: FontAwesomeIcons.envelope,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: const [AutofillHints.email],
            validator: (value) => Validators.validateEmail(value),
          ),
          SizedBox(
            height: 25.0.h,
          ),
          CustomTextField(
            controller: cubit.passwordController,
            hintText: AppStrings.password,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            prefixIcon: FontAwesomeIcons.lock,
            suffixIcon: cubit.suffix,
            obscureText: cubit.isPassword,
            suffixTab: () => cubit.changeVisibility(),
            validator: (value) => Validators.validatePassword(value),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () {
                navigateTo(context, Routes.forgetPass);
              },
              child: const Text(
                AppStrings.forgetPassword,
              ),
            ),
          ),
          SizedBox(
            height: 30.0.h,
          ),
          CustomButton(
            onTap: () async {
              if (formKey1.currentState!.validate()) {
                if (await checkInternetConnectivity()) {
                  await cubit.login();
                } else {
                  AppDialogs.showToast(msg: AppStrings.noInternetAccess);
                }
              }
            },
            text: AppStrings.login,
            condition: state is LoginLoadingState,
          ),
          SizedBox(
            height: 30.0.h,
          ),
          const DonTHaveAccount(),
        ],
      ),
    );
  }
}
