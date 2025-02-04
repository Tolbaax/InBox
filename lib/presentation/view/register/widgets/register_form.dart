import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/functions/app_dialogs.dart';
import '../../../../../core/functions/validators.dart';
import '../../../../../core/shared/common.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../components/buttons/custom_button.dart';
import '../../../components/text_fields/custom_text_field.dart';
import '../../../controllers/auth/auth_cubit.dart';
import '../../../controllers/auth/auth_states.dart';
import 'have_account.dart';

class RegisterForm extends StatelessWidget {
  final AuthCubit cubit;
  final AuthStates state;

  const RegisterForm({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool isUsernameTaken = false;

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: cubit.userNameController,
            hintText: AppStrings.userName,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: FontAwesomeIcons.userSecret,
            onChanged: (value) async {
              isUsernameTaken = await checkUsernameAvailability(value);
            },
            validator: (value) => Validators.validateUsername(value,
                isUsernameTaken: isUsernameTaken),
          ),
          SizedBox(
            height: 18.0.h,
          ),
          CustomTextField(
            controller: cubit.nameController,
            hintText: AppStrings.name,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: FontAwesomeIcons.user,
            validator: (value) => Validators.validateName(value),
          ),
          SizedBox(
            height: 18.0.h,
          ),
          CustomTextField(
            controller: cubit.emailController1,
            hintText: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: FontAwesomeIcons.envelope,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: const [AutofillHints.email],
            validator: (value) => Validators.validateEmail(value),
          ),
          SizedBox(
            height: 18.0.h,
          ),
          CustomTextField(
            controller: cubit.passwordController1,
            hintText: AppStrings.password,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            prefixIcon: FontAwesomeIcons.lock,
            suffixIcon: cubit.suffix1,
            obscureText: cubit.isPassword1,
            suffixTab: () => cubit.changeVisibility1(),
            validator: (value) => Validators.validatePassword(value),
          ),
          SizedBox(
            height: 18.0.h,
          ),
          CustomTextField(
            controller: cubit.confirmPassController,
            hintText: AppStrings.confirmPass,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            prefixIcon: FontAwesomeIcons.lock,
            suffixIcon: cubit.suffix2,
            obscureText: cubit.isPassword2,
            suffixTab: () => cubit.changeVisibility2(),
            validator: (value) => Validators.validateConfirmPassword(
              value,
              cubit.passwordController1.text.trim(),
            ),
          ),
          SizedBox(
            height: 40.0.h,
          ),
          CustomButton(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                if (await checkInternetConnectivity()) {
                  await cubit.register();
                } else {
                  AppDialogs.showToast(msg: AppStrings.noInternetAccess);
                }
              }
            },
            text: AppStrings.signUp,
            condition: state is RegisterLoadingState,
          ),
          SizedBox(
            height: 30.0.h,
          ),
          const HaveAccount(),
        ],
      ),
    );
  }
}
