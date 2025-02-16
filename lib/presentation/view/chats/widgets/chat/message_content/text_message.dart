import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/shared/common.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../domain/entities/message_entity.dart';
import 'time_sent_widget.dart';

class TextMessage extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;

  const TextMessage({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
              end: 7.0.w, start: 8.0.w, top: 5.0.h, bottom: 8.0.h),
          child: _buildMessageText(message.message),
        ),
        TimeSentWidget(message: message, isMe: isMe, isText: true),
      ],
    );
  }

  Widget _buildMessageText(String text) {
    return text.contains(RegExp(
        r'https?://|www\.|[\w\.-]+@[\w\.-]+\.\w+'))
        ? SelectableLinkify(
        text: text,
        onOpen: (link) async {
          final uri = Uri.parse(link.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        style:
        TextStyle(fontWeight: FontWeight.w500, color: AppColors.black),
        linkStyle: TextStyle(color: AppColors.primary))
        : ReadMoreText(
      text,
      trimLines: 24,
      trimMode: TrimMode.Line,
      trimExpandedText: ' ',
      moreStyle: TextStyle(color: AppColors.primary),
      textAlign: isArabic(text) ? TextAlign.end : TextAlign.start,
      style:
      TextStyle(fontWeight: FontWeight.w500, color: AppColors.black),
    );
  }
}
