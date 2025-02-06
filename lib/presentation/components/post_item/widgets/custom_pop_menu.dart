import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:inbox/core/utils/app_strings.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../../controllers/post/post_cubit.dart';

class CustomPubMenuButton extends StatefulWidget {
  final PostEntity post;
  final Widget child;

  const CustomPubMenuButton(
      {super.key, required this.child, required this.post});

  @override
  CustomPubMenuButtonState createState() => CustomPubMenuButtonState();
}

class CustomPubMenuButtonState extends State<CustomPubMenuButton> {
  bool isPostSaved = false;

  Future<void> updatePostSavedStatus() async {
    if (!mounted) return;

    final cubit = PostCubit.get(context);
    isPostSaved = await cubit.isPostInDrafts(widget.post.postID);
  }

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      updatePostSavedStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = PostCubit.get(context);
    final uID = FirebaseAuth.instance.currentUser!.uid;
    const String save = AppStrings.save;
    const String delete = AppStrings.delete;
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0.sp),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(value: save, child: _buildSaveMenuItem()),
        if (uID == widget.post.uID)
          PopupMenuItem(value: delete, child: _buildDeleteMenuItem()),
      ],
      onSelected: (value) async {
        if (value == delete) {
          AppDialogs.showConfirmDeletePost(context, onTap: () async {
            navigatePop(context);
            await cubit.deletePost(widget.post.postID);
            await CachedNetworkImage.evictFromCache(widget.post.imageUrl);
            AppDialogs.showToast(msg: AppStrings.postDeleteSuccess);
          });
        }

        if (value == save) {
          await cubit.savePost(widget.post.postID);
          await updatePostSavedStatus();
          final msg =
              isPostSaved ? AppStrings.postSaved : AppStrings.removedFromSaved;
          AppDialogs.showToast(msg: msg);
        }
      },
      child: widget.child,
    );
  }

  Widget _buildSaveMenuItem() {
    return Row(
      children: [
        Icon(
          isPostSaved
              ? FontAwesomeIcons.solidBookmark
              : FontAwesomeIcons.bookmark,
          color: AppColors.blackOlive.withOpacity(0.7),
          size: 18.0.sp,
        ),
        SizedBox(
          width: 15.0.w,
        ),
        Text(
          isPostSaved ? AppStrings.unSavePost : AppStrings.savePost,
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildDeleteMenuItem() {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.trashCan,
          color: AppColors.blackOlive.withOpacity(0.7),
          size: 18.0.sp,
        ),
        SizedBox(
          width: 15.0.w,
        ),
        const Text(
          AppStrings.deletePost,
          style: TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
