import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/injection/injector.dart';
import '../../../../core/utils/app_colors.dart';
import 'play_icon.dart';
import 'video_manager.dart';

class PostItemVideo extends StatefulWidget {
  final String videoUrl;

  const PostItemVideo({super.key, required this.videoUrl});

  @override
  State<PostItemVideo> createState() => _PostItemVideoState();
}

class _PostItemVideoState extends State<PostItemVideo> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayerFuture;
  bool _showIcon = false;
  bool _isInitialized = false;
  final VideoManager _videoManager = sl<VideoManager>();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..addListener(_videoListener);

    if (!_isInitialized) {
      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _videoManager.setController(_controller);
        });
      });
    }
  }

  void _videoListener() {
    if (!mounted || !_controller.value.isInitialized) return;
    setState(() => _showIcon = !_controller.value.isPlaying);
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted || !_controller.value.isInitialized) return;
    if (info.visibleFraction == 0) {
      _controller.pause();
    }
  }

  void _togglePlay() {
    if (!_controller.value.isInitialized) return;

    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _videoManager.setController(_controller);
      _controller.play();
    }
    setState(() => _showIcon = !_controller.value.isPlaying);
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: VisibilityDetector(
        key: Key(widget.videoUrl),
        onVisibilityChanged: _onVisibilityChanged,
        child: GestureDetector(
          onTap: _togglePlay,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.sp),
            child: Stack(
              alignment: Alignment.center,
              children: [
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (_isInitialized) {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      return Container(
                        height: 200.h,
                        color: AppColors.black,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                        ),
                      );
                    }
                  },
                ),
                AnimatedOpacity(
                  opacity: _showIcon ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const PlayIcon(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
