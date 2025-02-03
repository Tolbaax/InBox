import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:inbox/domain/entities/message_entity.dart';

import 'time_sent_widget.dart';

class ImageMessage extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;

  const ImageMessage({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final bool isImage = message.messageType == MessageType.image;

    return Padding(
      padding: EdgeInsets.all(2.5.sp),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0.sp),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    isImage ? context.height * 0.45 : context.height * 0.26,
                maxWidth: isImage ? context.width * 0.8 : context.width * 0.6,
              ),
              child: CachedNetworkImage(
                imageUrl: isImage ? message.fileUrl : message.message,
                maxHeightDiskCache: 390,
                errorWidget: (context, url, error) {
                  return SizedBox(
                    height: 130.0.sp,
                    width: 180.0.sp,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        size: 35.0.sp,
                        color: AppColors.black,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return SizedBox(
                    height: 110.0.sp,
                    width: 160.0.sp,
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2.0.sp),
                    ),
                  );
                },
              ),
            ),
          ),
          if (message.fileUrl.isNotEmpty && message.message.isEmpty)
            Positioned(
              bottom: 0.0.sp,
              right: 0.0.sp,
              child: TimeSentWidget(
                message: message,
                isMe: isMe,
                isText: false,
              ),
            ),
          if (message.fileUrl.isEmpty && message.message.isNotEmpty)
            Positioned(
              bottom: 0.0.sp,
              right: 0.0.sp,
              child: TimeSentWidget(
                message: message,
                isMe: isMe,
                isText: false,
              ),
            ),
        ],
      ),
    );
  }
}
