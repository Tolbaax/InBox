import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/extensions/media_query_extensions.dart';
import 'package:inbox/core/utils/app_colors.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/navigator.dart';
import '../widgets/camera/camera_appbar.dart';
import '../widgets/camera/select_image_from_gallery_button.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final String receiverId;
  final String name;

  const CameraScreen({super.key, required this.receiverId, required this.name});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  bool isFlashOn = false;
  bool isCameraFront = true;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() {
    try {
      _cameraController = CameraController(cameras[1], ResolutionPreset.max);
      _cameraValue = _cameraController.initialize();
      if (!mounted) {
        return;
      }
      setState(() {});
    } catch (e) {
      if (e is CameraException) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CameraAppBar(
        isFlashOn: isFlashOn,
        onFlashPressed: toggleFlash,
        isRecording: isRecording,
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          FutureBuilder(
            future: _cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: double.infinity,
                  height: context.height * 0.8,
                  child: CameraPreview(_cameraController),
                );
              } else {
                return SizedBox(
                  width: double.infinity,
                  height: context.height * 0.8,
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectImageFromGalleryButton(
                    receiverId: widget.receiverId, name: widget.name),
                GestureDetector(
                  onTap: () {
                    if (!isRecording) takePhoto(context);
                  },
                  onLongPress: () async {
                    await _cameraController.startVideoRecording();
                    setState(() {
                      isRecording = true;
                    });
                  },
                  onLongPressUp: () async {
                    XFile videoPath =
                        await _cameraController.stopVideoRecording();
                    setState(() {
                      isRecording = false;
                    });
                    if (!mounted) return;

                    if (context.mounted) {
                      navigateTo(
                        context,
                        Routes.sendingVideoViewRoute,
                        arguments: {
                          'uId': widget.receiverId,
                          'path': videoPath.path,
                          'name': widget.name,
                          'videoFile': File(videoPath.path),
                        },
                      );
                    }
                  },
                  child: cameraIcon(),
                ),
                GestureDetector(
                  onTap: toggleCameraFront,
                  child: CircleAvatar(
                    radius: 22.0.sp,
                    backgroundColor: Colors.black38,
                    child: Icon(
                      Icons.flip_camera_android_outlined,
                      color: AppColors.white,
                      size: 25.0.sp,
                      weight: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Icon cameraIcon() {
    return isRecording
        ? Icon(Icons.radio_button_on, color: Colors.red, size: 75.0.sp)
        : Icon(Icons.radio_button_checked_sharp,
            size: 75.0.sp, color: Colors.white);
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });

    isFlashOn
        ? _cameraController.setFlashMode(FlashMode.torch)
        : _cameraController.setFlashMode(FlashMode.off);
  }

  void toggleCameraFront() {
    setState(() {
      isCameraFront = !isCameraFront;
    });
    int cameraPos = isCameraFront ? 1 : 0;
    _cameraController =
        CameraController(cameras[cameraPos], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  void takePhoto(BuildContext context) async {
    XFile photoFile = await _cameraController.takePicture();
    if (!mounted) return;
    if (context.mounted) {
      navigateTo(context, Routes.sendingImageViewRoute, arguments: {
        'path': photoFile.path,
        'uId': widget.receiverId,
        'name': widget.name,
        'imageFile': File(photoFile.path),
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}
