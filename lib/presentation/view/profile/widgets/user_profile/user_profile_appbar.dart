import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/domain/entities/user_entity.dart';

import '../../../../../../core/utils/app_colors.dart';

class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserEntity user;

  const UserProfileAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(color: AppColors.black),
      title: SizedBox(
        width: context.width * 0.7,
        child: Text(user.username,style: TextStyle(fontSize: 16.5.sp)),
      ),
      centerTitle: false,
      titleSpacing: 0.0,
      actions: [
        IconButton(
          onPressed: () {},
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
