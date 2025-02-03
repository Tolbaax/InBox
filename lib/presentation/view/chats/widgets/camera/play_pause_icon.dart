import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class PlayPauseButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final VideoPlayerController controller;
  final bool isVideoCompleted;

  const PlayPauseButton({
    super.key,
    this.onTap,
    required this.isVideoCompleted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 27.0.sp,
            backgroundColor: Colors.black38,
            child: Icon(
              isVideoCompleted || !controller.value.isPlaying
                  ? Icons.play_arrow
                  : Icons.pause,
              color: Colors.white,
              size: 30.0.sp,
            ),
          ),
        ),
      ),
    );
  }
}
