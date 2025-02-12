import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/params/chat/delete_message_params.dart';

import '../../../../../../core/functions/navigator.dart';
import '../../../../../../core/injection/injector.dart';
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
          cubit.selectedMessageIds.length.toString(),
          style: TextStyle(color: AppColors.white, fontFamily: ''),
        ),
        const Spacer(),
        if (cubit.selectedMessageIds.length <= 1)
          _buildIconButton(FontAwesomeIcons.arrowTurnUp, -90, () async {
            await cubit.setIsReply();
          }),
        _buildIconButton(FontAwesomeIcons.copy, 0,
            () => _copyMessageToClipboard(cubit.selectedMessages)),
        _buildIconButton(
            FontAwesomeIcons.trashCan, 0, () => _handleDelete(context)),
        SizedBox(width: 15.w),
      ],
    );
  }

  void _handleDelete(BuildContext context) {
    final isMyMessages = cubit.isMyMessages;

    AppDialogs.showConfirmDeleteChatMessage(
      context,
      messageCount: cubit.selectedMessageIds.length,
      isMyMessages: isMyMessages,
      onTap: () async {
        navigatePop(context);
        await cubit.deleteMessages(
          DeleteMessageParams(
            receiverId: cubit.selectedReceiverId,
            messageIds: cubit.selectedMessageIds,
            isMyMessages: isMyMessages,
            deleteForMeWithEveryOne: sl<ChatCubit>().deleteForMeWithEveryOne,
          ),
        );
      },
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

  void _copyMessageToClipboard(List<String> messages) async {
    String text = messages.join("\n");
    Clipboard.setData(ClipboardData(text: text));
    AppDialogs.showToast(
        msg: messages.length == 1
            ? 'Message copied'
            : '${messages.length} messages copied');

    await cubit.removeSelected();
  }
}
