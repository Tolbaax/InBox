import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/settings_option.dart';
import '../widgets/delete_account_option.dart';
import '../widgets/logout_option.dart';
import '../widgets/settings_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 10.0.h,
          horizontal: 18.0.sp,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.height * 0.865,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsOption(
                  onTap: () {
                    navigateTo(context, Routes.editProfile);
                  },
                  icon: FontAwesomeIcons.userPen,
                  title: AppStrings.editProfile,
                ),
                SettingsOption(
                  onTap: () => navigateTo(context, Routes.drafts),
                  icon: FontAwesomeIcons.bookmark,
                  title: AppStrings.saved,
                ),
                SettingsOption(
                  onTap: () {},
                  icon: FontAwesomeIcons.sun,
                  title: AppStrings.theme,
                ),
                SettingsOption(
                  onTap: () => launchUrl(
                    Uri.parse(AppStrings.privacyPolicyUrl),
                    mode: LaunchMode.externalApplication,
                  ),
                  icon: FontAwesomeIcons.shieldHalved,
                  title: AppStrings.privacyPolicy,
                ),
                const LogoutOption(),
                Spacer(),
                DeleteAccountOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
