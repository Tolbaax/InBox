import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/shared/common.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/app_dialogs.dart';
import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../controllers/auth/auth_cubit.dart';
import '../../../controllers/layout/layout_cubit.dart';
import '../../../controllers/user/user_cubit.dart';
import 'settings_option.dart';

class LogoutOption extends StatelessWidget {
  const LogoutOption({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);

    return SettingsOption(
      onTap: () {
        AppDialogs.showLogOutDialog(
            context: context,
            onPressed: () {
              cubit.signOut().then((value) async{
                await clearCache();
                if (context.mounted) navigateAndRemove(context, Routes.login);
              });
              UserCubit.get(context).setUserState(isOnline: false);
              cubit.clearSignInControllers();
              cubit.clearSignUpControllers();
              LayoutCubit.get(context).selectedIndex = 0;
            });
      },
      icon: FontAwesomeIcons.arrowRightFromBracket,
      title: AppStrings.logout,
    );
  }
}
