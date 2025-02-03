import 'package:flutter/material.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../../../components/buttons/appbar_back_button.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarBackButton(),
      title: const Text(
        AppStrings.settings,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
