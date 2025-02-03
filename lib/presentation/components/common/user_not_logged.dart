import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../buttons/custom_button.dart';

class UserNotLogged extends StatelessWidget {
  const UserNotLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width * 0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User is not logged in',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.0.sp,
              ),
            ),
            SizedBox(height: context.height * 0.08),
            CustomButton(
              onTap: () => navigateAndRemove(context, Routes.login),
              text: AppStrings.backToLogin,
            ),
          ],
        ),
      ),
    );
  }
}
