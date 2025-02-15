import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/shared/common.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';

class AddPostDraggableSheet extends StatelessWidget {
  const AddPostDraggableSheet({super.key});

  final double initialChildSize = 0.27;
  final double minChildSize = 0.095;
  final double maxChildSize = 0.27;

  @override
  Widget build(BuildContext context) {
    final cubit = AddPostCubit.get(context);
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17.0.sp),
              topRight: Radius.circular(17.0.sp),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.15),
                spreadRadius: 4.sp,
                blurRadius: 8.sp,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Column(
                children: [
                  SizedBox(height: 7.0.h),
                  Container(
                    height: 3.5.h,
                    width: context.width * 0.14,
                    decoration: BoxDecoration(
                      color: AppColors.blackOlive.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0.sp),
                    ),
                  ),
                  _buildListTile(
                    onTap: () =>
                        AppDialogs.selectImageOrVideoDialog(context, cubit),
                    icon: FontAwesomeIcons.image,
                    color: Colors.green,
                    text: AppStrings.photoVideo,
                  ),
                ],
              ),
              Divider(height: 0.0, color: AppColors.gray.withOpacity(0.4)),
              _buildListTile(
                onTap: () => cubit.getPostImageFromCamera(context),
                icon: FontAwesomeIcons.camera,
                color: AppColors.nickel,
                text: AppStrings.camera,
              ),
              Divider(height: 0.0, color: AppColors.gray.withOpacity(0.4)),
              _buildListTile(
                onTap: () async {
                  if (await checkInternetConnectivity()) {
                    if (context.mounted) await cubit.pickGifUrl(context);
                  } else {
                    AppDialogs.showToast(msg: 'Check Internet Connection!');
                  }
                },
                icon: Icons.gif_box,
                color: Colors.purple,
                text: AppStrings.gif,
                iconSize: 25.0.sp,
              ),
              // Divider(height: 0.0, color: AppColors.gray.withOpacity(0.4)),
              // _buildListTile(
              //   onTap: () {},
              //   icon: FontAwesomeIcons.music,
              //   color: Colors.pink,
              //   text: AppStrings.music,
              // ),
              // Divider(height: 0.0, color: AppColors.gray.withOpacity(0.4)),
              // _buildListTile(
              //   onTap: () {},
              //   icon: Icons.location_on,
              //   color: AppColors.red,
              //   text: AppStrings.location,
              //   iconSize: 25.0.sp,
              // ),
              // Divider(height: 0.0, color: AppColors.gray.withOpacity(0.4)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTile({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    required String text,
    double iconSize = 30.0,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color, size: iconSize),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
