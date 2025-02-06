import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../components/buttons/profile_button.dart';
import '../../../../components/post_item/widgets/video_manager.dart';
import '../../../../controllers/user/user_cubit.dart';
import '../../../../controllers/user/user_states.dart';
import '../../screens/edit_profile_screen.dart';
import '../common/profile_header.dart';

class MyProfileHeader extends StatelessWidget {
  const MyProfileHeader({super.key});

  @override
  Widget build(context) {
    var user = UserCubit.get(context).userEntity;

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is GetCurrentUserSuccessState) {
          user = UserCubit.get(context).userEntity;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 15.0.sp),
          child: Column(
            children: [
              ProfileHeader(user: user!, isMe: true),
              Row(
                children: [
                  Expanded(
                    child: ProfileButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const EditProfileScreen()));
                        sl<VideoManager>().stopCurrentVideo();
                      },
                      text: AppStrings.editProfile,
                    ),
                  ),
                  SizedBox(
                    width: 12.0.w,
                  ),
                  Expanded(
                    child: ProfileButton(
                      //TODO: upload app then use Dynamic Links
                      onTap: () => Share.share(
                        'Check out my github profile:\nhttps://github.com/Tolbaax',
                      ),
                      text: AppStrings.shareProfile,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0.h),
            ],
          ),
        );
      },
    );
  }
}
