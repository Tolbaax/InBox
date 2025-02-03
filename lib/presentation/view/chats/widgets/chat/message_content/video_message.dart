import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/domain/entities/message_entity.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../components/post_item/widgets/play_icon.dart';
import 'time_sent_widget.dart';

class VideoMessage extends StatefulWidget {
  final MessageEntity message;
  final bool isMe;

  const VideoMessage({super.key, required this.isMe, required this.message});

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  late VideoPlayerController _controller;
  bool _isVideoCompleted = false;
  bool showIcon = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.message.fileUrl))
          ..addListener(_videoListener);
    await _controller.initialize();

    _controller.addListener(_checkVideoCompletion);

    setState(() {});
  }

  void _checkVideoCompletion() {
    setState(() {
      _isVideoCompleted =
          _controller.value.position == _controller.value.duration;
    });
  }

  void _videoListener() =>
      setState(() => showIcon = !_controller.value.isPlaying);

  @override
  Widget build(BuildContext context) {
    final aspectRatio = _controller.value.aspectRatio;

    return Padding(
      padding: EdgeInsets.all(2.5.sp),
      child: VisibilityDetector(
        key: Key(widget.message.fileUrl),
        onVisibilityChanged: _onVisibilityChanged,
        child: GestureDetector(
          onTap: _onTap,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                width: context.width * 0.96,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0.sp),
                  child: AspectRatio(
                    aspectRatio: aspectRatio < 3 / 4 ? 3 / 4 : aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              if (showIcon) const PlayIcon(),
              if (widget.message.fileUrl.isNotEmpty &&
                  widget.message.message.isEmpty)
                Positioned(
                  bottom: 0.0.sp,
                  right: 0.0.sp,
                  child: TimeSentWidget(
                    message: widget.message,
                    isMe: widget.isMe,
                    isText: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onVisibilityChanged(VisibilityInfo visibilityInfo) {
    if (mounted) {
      setState(() {
        showIcon =
            !_controller.value.isPlaying || visibilityInfo.visibleFraction == 0;
        if (visibilityInfo.visibleFraction == 0) _controller.pause();
        // To auto play videos:
        // else if (!_controller.value.isPlaying) _controller.play();
      });
    }
  }

  void _onTap() {
    setState(() {
      if (_isVideoCompleted) {
        _controller.seekTo(Duration.zero);
        _controller.play();
      } else if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      showIcon = !_controller.value.isPlaying;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }
}
