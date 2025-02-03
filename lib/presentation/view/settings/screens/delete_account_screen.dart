import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_strings.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../components/buttons/appbar_back_button.dart';
import '../widgets/delete_account_form.dart';
import '../widgets/unorderd_list_item.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text(AppStrings.deleteThisAccount),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.0.w,
            vertical: 10.0.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.triangleExclamation,
                    color: AppColors.red,
                    size: 20.0.sp,
                  ),
                  SizedBox(width: context.width * 0.05),
                  Text(
                    AppStrings.ifDeleteThisAccount,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0.sp,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.height * 0.02),
              const UnorderedListItem(text: AppStrings.deleteAccountInfo1),
              const UnorderedListItem(text: AppStrings.deleteAccountInfo2),
              const UnorderedListItem(text: AppStrings.deleteAccountInfo3),
              const UnorderedListItem(text: AppStrings.deleteAccountInfo4),
              Divider(
                color: AppColors.grayRegular.withOpacity(0.7),
                indent: context.width * 0.11,
              ),
              SizedBox(height: context.height * 0.03),
              const DeleteAccountForm(),
            ],
          ),
        ),
      ),
    );
  }
}
