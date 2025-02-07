import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../controllers/chat/chat_cubit.dart';

class SelectionModeAppBar extends StatelessWidget {
  final ChatCubit cubit;

  const SelectionModeAppBar({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 10.w),
        Text(
          cubit.selectedMessages.length.toString(),
          style: TextStyle(color: AppColors.white, fontFamily: ''),
        ),
        const Spacer(),
        if (cubit.selectedMessages.length <= 1)
          _buildIconButton(FontAwesomeIcons.arrowTurnUp, -90, () {}),
        _buildIconButton(FontAwesomeIcons.copy, 0, () {}),
        _buildIconButton(FontAwesomeIcons.trashCan, 0, () {}),
        SizedBox(width: 15.w),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, double rotation, VoidCallback onTap) {
    return IconButton(
      icon: Transform.rotate(
        angle: rotation * (3.14 / 180),
        child: Icon(icon, color: AppColors.white, size: 19.sp),
      ),
      onPressed: onTap,
    );
  }
}
