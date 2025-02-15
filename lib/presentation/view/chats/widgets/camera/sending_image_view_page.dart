import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import '../../../../../../../core/shared/common.dart';
import '../../../../../core/injection/injector.dart';
import 'image_view_top_icons.dart';
import 'sending_image_video_bottom_field.dart';

class SendingImageViewPage extends StatefulWidget {
  final String path;
  final String receiverId;
  final String name;
  final File imageFile;

  const SendingImageViewPage({
    super.key,
    required this.path,
    required this.receiverId,
    required this.name,
    required this.imageFile,
  });

  @override
  State<SendingImageViewPage> createState() => _SendingImageViewPageState();
}

class _SendingImageViewPageState extends State<SendingImageViewPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = sl<ChatCubit>();

    return BlocProvider.value(
      value: sl<ChatCubit>(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(
              cubit.messageImage == null
                  ? widget.path
                  : cubit.messageImage!.path,
            )),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: context.width,
            leading: ImageViewTopRowIcons(
              onCropButtonTaped: () {
                cropImage(widget.path).then((value) {
                  if (context.mounted) {
                    sl<ChatCubit>().messageImage = value;
                  }
                });
              },
            ),
            toolbarHeight: context.height * 0.13,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SendingImageVideoBottomField(
                  receiverId: widget.receiverId,
                  name: widget.name,
                  messageType: MessageType.image,
                  messageFile: widget.imageFile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
