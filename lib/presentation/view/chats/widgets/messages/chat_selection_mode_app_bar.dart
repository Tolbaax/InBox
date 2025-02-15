import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';
import '../../../../../core/functions/app_dialogs.dart';
import '../../../../../core/functions/navigator.dart';

class ChatSelectionModeAppBar extends StatelessWidget {
  final MessagesCubit cubit;

  const ChatSelectionModeAppBar({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BackButton(
          style: ButtonStyle(
              alignment: AlignmentDirectional.centerStart,
              padding: WidgetStateProperty.all(EdgeInsets.zero)),
          onPressed: () {
            cubit.removeSelectedChats();
          },
        ),
        const Spacer(),
        IconButton(
          icon: Icon(FontAwesomeIcons.trashCan, size: 18.sp),
          onPressed: () async {
            _handleDeleteChat(context);
          },
        ),
        SizedBox(width: 15.w),
      ],
    );
  }

  void _handleDeleteChat(BuildContext context) {
    AppDialogs.showConfirmDeleteChat(
      context,
      messageCount: cubit.selectedChatIds.length,
      onTap: () async {
        await cubit.deleteChats();
        if (context.mounted) navigatePop(context);
        cubit.removeSelectedChats();
      },
    );
  }
}
