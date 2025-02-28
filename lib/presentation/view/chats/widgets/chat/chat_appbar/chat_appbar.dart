import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/core/functions/navigator.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../controllers/chat/chat_states.dart';
import 'message_selection_mode_app_bar.dart';
import 'user_info_app_bar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String receiverId;
  final String name;
  final String imageUrl;

  const ChatAppBar({
    super.key,
    required this.receiverId,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        final cubit = context.read<ChatCubit>();

        return AppBar(
          backgroundColor: AppColors.policeBlue,
          leading: BackButton(
            color: AppColors.white,
            onPressed: () async {
              if (cubit.selectedMessageIds.isEmpty) {
                navigatePop(context);
              } else {
                await cubit.removeSelected();
              }
            },
          ),
          leadingWidth: 38.w,
          titleSpacing: 0.0,
          toolbarHeight: kToolbarHeight,
          title: cubit.isSelecting
              ? MessageSelectionModeAppBar(cubit: cubit)
              : UserInfoAppBar(
                  receiverId: receiverId, name: name, imageUrl: imageUrl),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1.h);
}
