import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';

class EmojiPickerWidget extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onGifButtonTap;
  final bool isShowEmoji;
  final bool isCameraRev;

  const EmojiPickerWidget({
    super.key,
    required this.onGifButtonTap,
    required this.messageController,
    required this.isShowEmoji,
    required this.isCameraRev,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: context.height * 0.36),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          EmojiPicker(
            textEditingController: messageController,
            onBackspacePressed: () {},
            config: Config(
              checkPlatformCompatibility: true,
              categoryViewConfig: CategoryViewConfig(
                backgroundColor: AppColors.white,
              ),
              searchViewConfig: SearchViewConfig(
                backgroundColor: AppColors.white,
              ),
              bottomActionBarConfig: BottomActionBarConfig(
                backgroundColor: AppColors.white,
                buttonIconColor: AppColors.grayRegular,
                buttonColor: AppColors.white,
              ),
              emojiViewConfig: EmojiViewConfig(
                backgroundColor: AppColors.white,
                emojiSizeMax: 25.0.sp,
                columns: 8,
              ),
            ),
          ),
          if (!isCameraRev)
            Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: onGifButtonTap,
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                  margin: EdgeInsetsDirectional.symmetric(
                      horizontal: context.width * 0.2, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0.sp),
                    border: Border.all(color: AppColors.grayRegular),
                  ),
                  child: Text(
                    'GIF',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
