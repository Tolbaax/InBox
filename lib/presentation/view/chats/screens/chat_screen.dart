import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/utils/assets_manager.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import '../widgets/chat/chat_field/bottom_chat_field.dart';
import '../widgets/chat/chat_appbar/chat_appbar.dart';
import '../widgets/chat/chat_messages_list/chat_messages_list.dart';

class ChatScreen extends StatelessWidget {
  final String uID;
  final String name;

  const ChatScreen({super.key, required this.uID, required this.name});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await context.read<ChatCubit>().onPopInvokedWithResult(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImgAssets.whatsappLightBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: ChatAppBar(receiverId: uID),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatMessagesList(receiverId: uID),
              BottomChatField(receiverId: uID, name: name),
            ],
          ),
        ),
      ),
    );
  }
}
