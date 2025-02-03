import 'package:flutter/material.dart';

import '../../../../../../../core/functions/navigator.dart';

class CameraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFlashPressed;
  final bool isFlashOn;
  final bool isRecording;

  const CameraAppBar({
    super.key,
    required this.onFlashPressed,
    required this.isFlashOn,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    return isRecording
        ? AppBar(leading: const Text(''))
        : AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                navigatePop(context);
              },
              icon: const Icon(Icons.clear),
            ),
            actions: [
              IconButton(
                onPressed: onFlashPressed,
                icon: Icon(
                  isFlashOn ? Icons.flash_on : Icons.flash_off,
                ),
              ),
            ],
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
