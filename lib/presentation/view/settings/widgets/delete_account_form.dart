import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/functions/validators.dart';
import 'package:inbox/core/utils/app_colors.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/shared/common.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../core/injection/injector.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../components/text_fields/custom_text_field.dart';
import '../../../controllers/user/user_cubit.dart';
import '../../../controllers/user/user_states.dart';

class DeleteAccountForm extends StatefulWidget {
  const DeleteAccountForm({super.key});

  @override
  State<DeleteAccountForm> createState() => _DeleteAccountFormState();
}

class _DeleteAccountFormState extends State<DeleteAccountForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<UserCubit>(),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          final user = context.read<UserCubit>().userEntity;

          return Padding(
            padding: EdgeInsetsDirectional.only(start: context.width * 0.11),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDeleteAccountConfirmText(),
                  SizedBox(height: context.height * 0.04),
                  _buildEmailTextField(user),
                  SizedBox(height: context.height * 0.05),
                  _buildDeleteAccountButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeleteAccountConfirmText() {
    return Text(
      AppStrings.toDeleteAccountConfirm,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13.15.sp,
      ),
    );
  }

  Widget _buildEmailTextField(UserEntity? user) {
    return CustomTextField(
        controller: emailController,
        hintText: AppStrings.email,
        keyboardType: TextInputType.emailAddress,
        prefixIcon: FontAwesomeIcons.envelope,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: const [AutofillHints.email],
        validator: (value) => Validators.validateDeleteAccount(value, user!));
  }

  Widget _buildDeleteAccountButton() {
    return GestureDetector(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          if (await checkInternetConnectivity()) {
            if (mounted) FocusScope.of(context).unfocus();
            if (mounted) {
              await navigateTo(context, Routes.confirmDeleteAccount);
            }
            emailController.clear();
          } else {
            AppDialogs.showToast(msg: AppStrings.noInternetAccess);
          }
        }
      },
      child: Container(
        height: 35.0.h,
        width: context.width * 0.45,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        child: Center(
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
    );
  }
}
