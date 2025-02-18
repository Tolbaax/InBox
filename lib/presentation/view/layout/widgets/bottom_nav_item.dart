import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../core/injection/injector.dart';

class BottomNavItem extends StatelessWidget {
  final int index;
  final bool isActive;

  const BottomNavItem({super.key, required this.index, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color =
        isActive ? AppColors.primary : AppColors.black.withOpacity(0.5);
    final double iconSize = isActive ? 17.0.sp : 16.5.sp;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: index == 0 ? 4.5.w : 0.0),
          child: index == 2
              ? UnreadChatsBadge(index: index, color: color)
              : Icon(
                  Constants.iconList[index],
                  size: iconSize,
                  color: color,
                ),
        ),
        SizedBox(height: 1.h),
        Text(
          Constants.titles[index],
          style: TextStyle(
            color: color,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class UnreadChatsBadge extends StatelessWidget {
  final int index;
  final Color color;

  const UnreadChatsBadge({super.key, required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: sl<MessagesCubit>().getUnreadChatsCount(),
      builder: (context, snapshot) {
        final unreadChatsCount = snapshot.data ?? 0;

        if (index == 2 && unreadChatsCount > 0) {
          return Badge.count(
            count: unreadChatsCount,
            offset: const Offset(8, -5),
            backgroundColor: AppColors.red,
            child: Icon(
              Constants.iconList[index],
              size: 17.0.sp,
              color: AppColors.primary,
            ),
          );
        }

        return Icon(
          Constants.iconList[index],
          size: 17.0.sp,
          color: color,
        );
      },
    );
  }
}
