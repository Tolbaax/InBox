import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/utils/app_strings.dart';
import '../../presentation/components/buttons/profile_button.dart';
import '../../presentation/controllers/post/add_post/add_post_cubit.dart';
import '../utils/app_colors.dart';

class AppDialogs {
  static void showToast(
      {required String msg, Color? color, ToastGravity? gravity}) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      backgroundColor: color ?? AppColors.primary,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }

  static void showLogOutDialog({context, VoidCallback? onPressed}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0.sp)),
        title: Icon(
          CupertinoIcons.exclamationmark_circle,
          size: 55.0.sp,
          color: AppColors.primary,
        ),
        content: Padding(
          padding: EdgeInsetsDirectional.only(top: 7.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you leaving?',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 17.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8.0.h,
              ),
              Text(
                'Are you sure want to log out?',
                style: TextStyle(fontSize: 14.0.sp),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.black,
              textStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              textStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            child: const Text(AppStrings.logout),
          ),
        ],
      ),
    );
  }

  static void selectImageOrVideoDialog(context, AddPostCubit cubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0.sp)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                cubit.pickImage(context);
                navigatePop(context);
              },
              child: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.85),
                radius: 30.0.sp,
                child: Icon(
                  FontAwesomeIcons.image,
                  color: AppColors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                cubit.pickVideo();
                navigatePop(context);
              },
              child: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.85),
                radius: 30.0.sp,
                child: Icon(
                  FontAwesomeIcons.video,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showDiscardPostDialog(context, AddPostCubit cubit) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: context.height * 0.65,
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
              ),
              contentPadding: EdgeInsetsDirectional.only(
                  top: 15.0.sp, bottom: 25.0.sp, end: 12.0.sp, start: 12.0.sp),
              content: Column(
                children: [
                  Text(
                    AppStrings.discardPost,
                    style: TextStyle(
                      fontSize: 17.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  SizedBox(
                    width: context.width * 0.54,
                    child: ProfileButton(
                      onTap: () {
                        cubit.postTextController.clear();
                        cubit.postImage = null;
                        if (cubit.video != null) {
                          cubit.videoPlayerController!.dispose();
                          cubit.video = null;
                        }
                        navigateAndRemove(context, Routes.layout);
                      },
                      text: AppStrings.discard,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  SizedBox(
                    width: context.width * 0.54,
                    height: 28.0.h,
                    child: OutlinedButton(
                      onPressed: () => navigatePop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0.r),
                        ),
                      ),
                      child: Text(
                        AppStrings.cancel,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 13.4.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showConfirmDeletePost(context,
      {required GestureTapCallback onTap}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: context.height * 0.65,
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
              ),
              contentPadding: EdgeInsetsDirectional.only(
                  top: 15.0.sp, bottom: 25.0.sp, end: 12.0.sp, start: 12.0.sp),
              content: Column(
                children: [
                  Text(
                    '${AppStrings.deletePost}?',
                    style: TextStyle(
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 7.0.h,
                  ),
                  Text(
                    AppStrings.sureDeletePost,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  SizedBox(
                    width: context.width * 0.54,
                    child: ProfileButton(
                      onTap: onTap,
                      text: AppStrings.delete,
                      color: AppColors.red,
                    ),
                  ),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  SizedBox(
                    width: context.width * 0.54,
                    height: 28.0.h,
                    child: OutlinedButton(
                      onPressed: () => navigatePop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0.r),
                        ),
                      ),
                      child: Text(
                        AppStrings.cancel,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 13.4.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
