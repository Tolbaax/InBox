import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/utils/app_colors.dart';

class FirstMessageSmallCurvedBubble extends StatelessWidget {
  final bool isMe;

  const FirstMessageSmallCurvedBubble({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(isMe),
      child: Container(
        width: 8.0.w,
        height: 10.0.h,
        decoration: BoxDecoration(
          color: isMe ? AppColors.water : Colors.white,
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final bool isMe;

  MyCustomClipper(this.isMe);

  @override
  Path getClip(Size size) {
    return isMe ? myCustomRightPath(size) : senderCustomLeftPath(size);
  }

  Path myCustomRightPath(Size size) {
    final double w = size.width;
    final double h = size.height;
    final Path path = Path()
      ..lineTo(w - 2.5, 0)
      ..quadraticBezierTo(w, 2.5, w - 2.5, 4)
      ..lineTo(0, h)
      ..close();
    return path;
  }

  Path senderCustomLeftPath(Size size) {
    final double w = size.width;
    final double h = size.height;
    final Path path = Path()
      ..lineTo(2.5, 0)
      ..quadraticBezierTo(0, 2.5, 2.5, 4)
      ..lineTo(w, h)
      ..lineTo(w, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
