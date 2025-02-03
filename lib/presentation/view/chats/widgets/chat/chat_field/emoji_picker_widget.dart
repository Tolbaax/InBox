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
              emojiViewConfig: EmojiViewConfig(
                emojiSizeMax: 25.0.sp,
                columns: 8,
              ),
            ),
          ),
          if (!isCameraRev)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h),
                child: InkWell(
                  onTap: onGifButtonTap,
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                        horizontal: context.width * 0.43, vertical: 1),
                    decoration: BoxDecoration(
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
            ),
        ],
      ),
    );
  }
}
