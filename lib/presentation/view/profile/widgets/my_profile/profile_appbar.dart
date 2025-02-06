import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/presentation/components/post_item/widgets/video_manager.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../controllers/user/user_cubit.dart';
import '../../../../controllers/user/user_states.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool fromSearch;

  const ProfileAppBar({super.key, required this.fromSearch});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = UserCubit.get(context).userEntity;
        return AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          title: Text(
            user == null ? '' : user.username,
            style: TextStyle(fontSize: 16.5.sp),
          ),
          centerTitle: false,
          titleSpacing: fromSearch ? 0.0 : 16.0.sp,
          actions: [
            IconButton(
              onPressed: () {
                navigateTo(context, Routes.settings);
                sl<VideoManager>().stopCurrentVideo();
              },
              splashColor: AppColors.lightBlue.withOpacity(0.38),
              splashRadius: 20.0.sp,
              icon: Icon(
                FontAwesomeIcons.bars,
                size: 22.5.sp,
                color: AppColors.blackOlive,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kMinInteractiveDimension - 8.0.sp);
}
