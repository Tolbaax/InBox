import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inbox/config/routes/app_routes.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/functions/navigator.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../core/shared/common.dart';
import '../../../components/buttons/profile_button.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';
import '../../../controllers/post/add_post/add_post_states.dart';

class AddPostAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AddPostAppBar({super.key});

  @override
  State<AddPostAppBar> createState() => _AddPostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AddPostAppBarState extends State<AddPostAppBar> {
  late bool isEmpty = true;
  late AddPostCubit cubit = AddPostCubit.get(context);

  @override
  void initState() {
    super.initState();
    isEmpty = cubit.postTextController.text.isEmpty;

    cubit.postTextController.addListener(_onPostTextChanged);
  }

  @override
  void dispose() {
    cubit.postTextController.removeListener(_onPostTextChanged);
    super.dispose();
  }

  void _onPostTextChanged() {
    setState(() {
      isEmpty = cubit.postTextController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostCubit, AddPostStates>(
        listener: (context, state) {
      if (state is AddPostSuccessState) {
        navigateAndRemove(context, Routes.layout);
      }
    }, builder: (context, state) {
      final cubit = AddPostCubit.get(context);

      bool isMedia = (state is PickPostImageSuccessState) ||
          (state is PickVideoSuccessState) ||
          (state is PickedGifSuccessState);

      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          await _onPopInvokedWithResult(context, cubit, isMedia);
        },
        child: AppBar(
          leading: BackButton(color: AppColors.blackOlive),
          title: Text(
            AppStrings.createPost,
            style: TextStyle(
              color: AppColors.blackOlive.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              fontSize: 15.0.sp,
            ),
          ),
          centerTitle: false,
          titleSpacing: 0.0,
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10.0.h),
              child: SizedBox(
                width: 75.0.sp,
                child: state is AddPostLoadingState
                    ? SpinKitFadingCircle(
                        color: AppColors.primary,
                        size: 32.0.sp,
                      )
                    : ProfileButton(
                        onTap: () async {
                          if (isMedia || !isEmpty) {
                            if (await checkInternetConnectivity()) {
                              await cubit.addPost();
                            } else {
                              AppDialogs.showToast(
                                  msg: AppStrings.noInternetAccess);
                            }
                          }
                        },
                        text: AppStrings.post,
                        color: isMedia || !isEmpty ? AppColors.primary : null,
                      ),
              ),
            ),
            SizedBox(
              width: 12.0.w,
            ),
          ],
        ),
      );
    });
  }

  Future<void> _onPopInvokedWithResult(
      BuildContext context, cubit, bool isMedia) async {
    if (isMedia || !isEmpty) {
      return AppDialogs.showDiscardPostDialog(context, cubit);
    }
    if (Navigator.of(context).canPop()) {
      navigatePop(context);
    }
  }
}
