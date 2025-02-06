import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:video_player/video_player.dart';
import 'play_pause_icon.dart';
import 'sending_image_video_bottom_field.dart';
import 'video_view_top_icons.dart';

class SendingVideoViewPage extends StatefulWidget {
  final String path;
  final String receiverId;
  final String name;
  final File videoFile;

  const SendingVideoViewPage({
    super.key,
    required this.path,
    required this.receiverId,
    required this.name,
    required this.videoFile,
  });

  @override
  State<SendingVideoViewPage> createState() => _SendingVideoViewPageState();
}

class _SendingVideoViewPageState extends State<SendingVideoViewPage> {
  late VideoPlayerController _controller;
  bool _isVideoCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then(
        (_) => setState(() {}),
      );

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          _isVideoCompleted = true;
        });
      } else {
        setState(() {
          _isVideoCompleted = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: context.width,
        leading: const VideoViewTopRowWidget(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: context.height * 0.8,
              child: Visibility(
                visible: _controller.value.isInitialized,
                child: SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),
            PlayPauseButton(
              onTap: _onTap,
              isVideoCompleted: _isVideoCompleted,
              controller: _controller,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SendingImageVideoBottomField(
                receiverId: widget.receiverId,
                name: widget.name,
                messageType: MessageType.video,
                messageFile: widget.videoFile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (_isVideoCompleted) {
      _controller.seekTo(Duration.zero);
      _controller.play();
    }

    setState(() {
      if (_controller.value.isPlaying || _isVideoCompleted) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
