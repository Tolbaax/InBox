import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import '../../../../../../core/utils/app_colors.dart';

class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String uID;
  final String username;

  const UserProfileAppBar(
      {super.key, required this.uID, required this.username});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(color: AppColors.black),
      title: SizedBox(
        width: context.width * 0.7,
        child: Text(
          username,
          style: TextStyle(fontSize: 16.5.sp),
        ),
      ),
      centerTitle: false,
      titleSpacing: 0.0,
      actions: [
        IconButton(
          onPressed: () =>
              AppDialogs.showProfileOptionsSheet(context, uID: uID),
          splashColor: AppColors.lightBlue.withOpacity(0.38),
          splashRadius: 20.0.sp,
          icon: Icon(
            FontAwesomeIcons.ellipsisVertical,
            color: AppColors.blackOlive,
            size: 18.0.sp,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
