import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../components/post_item/widgets/play_icon.dart';
import '../../../controllers/post/add_post/add_post_cubit.dart';

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
                      aspectRatio: aspectRatio < 3 / 4 ? 3 / 4 : aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: IconButton(
                    splashRadius: 20.0.sp,
                    alignment: AlignmentDirectional.topEnd,
                    onPressed: () => widget.cubit.disposeVideo(),
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      color: AppColors.white,
                      shadows: [
                        BoxShadow(
                          color: AppColors.black,
                          spreadRadius: 1.sp,
                          blurRadius: 5.sp,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
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
