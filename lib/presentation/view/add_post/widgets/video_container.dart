import 'package:flutter/material.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:video_player/video_player.dart';

import '../../../components/post_item/widgets/play_icon.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';
import 'cancel_post_icon.dart';

class VideoContainer extends StatefulWidget {
  final AddPostCubit cubit;

  const VideoContainer({super.key, required this.cubit});

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.cubit.videoPlayerController;
    if (controller == null) return const SizedBox.shrink();
    late double aspectRatio = controller.value.aspectRatio;
    bool showIcon = false;
    controller.addListener(() {
      if (!controller.value.isPlaying && mounted) {
        setState(() {
          showIcon = true;
        });
      }
    });

    return Column(
      children: [
        if (widget.cubit.video != null && controller.value.isInitialized)
          GestureDetector(
            onTap: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
                showIcon = !showIcon;
              });
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: context.height * 0.44,
                    maxWidth: context.height * 0.44,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),
                CancelPostIcon(onPressed: () => widget.cubit.disposeVideo()),
                if (!controller.value.isPlaying || showIcon) const PlayIcon(),
              ],
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
