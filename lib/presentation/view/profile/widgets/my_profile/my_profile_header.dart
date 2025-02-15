import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../../core/injection/injector.dart';
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
    var user = context.read<UserCubit>().userEntity;

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is GetCurrentUserSuccessState) {
          user = context.read<UserCubit>().userEntity;
        }
      },
      builder: (context, state) {
        String generateProfileLink() {
          return 'https://www.inbox.com/profile/${user!.uID}';
        }

        void shareProfile() {
          final link = generateProfileLink();
          Share.share('Check out this profile: \n$link');
        }

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
                      onTap: () => shareProfile(),
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
