import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'play_icon.dart';

class PostItemVideo extends StatefulWidget {
  final String videoUrl;

  const PostItemVideo({super.key, required this.videoUrl});

  @override
  State<PostItemVideo> createState() => _PostItemVideoState();
}

class _PostItemVideoState extends State<PostItemVideo> {
  late VideoPlayerController _controller;
  bool showIcon = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..addListener(_videoListener);
    await _controller.initialize();

    setState(() {});
  }

  void _videoListener() =>
      setState(() => showIcon = !_controller.value.isPlaying);

  @override
  Widget build(BuildContext context) {
    final aspectRatio = _controller.value.aspectRatio;

    return Padding(
      padding: EdgeInsetsDirectional.only(top: 5.h, start: 10.w, end: 10.w),
      child: VisibilityDetector(
        key: Key(widget.videoUrl),
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
      if (_controller.value.isPlaying) {
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
