import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';
import 'package:inbox/presentation/controllers/messages/messages_states.dart';
import '../../../../../core/injection/injector.dart';
import '../../search/widgets/no_users_found.dart';
import '../../search/widgets/shimmer_user_card.dart';
import '../widgets/messages/message_app_bar.dart';
import '../widgets/messages/message_card.dart';
import '../widgets/messages/no_messages_yet.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<MessagesCubit>(),
      child: BlocBuilder<MessagesCubit, MessagesState>(
        builder: (context, state) {
          final cubit = context.read<MessagesCubit>();
          return Scaffold(
            appBar: MessagesAppBar(cubit: cubit),
            body: _buildBody(context, cubit),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, MessagesCubit cubit) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        if (cubit.searchQuery.isNotEmpty) {
          return _buildSearchResults(cubit);
        } else {
          return _buildChatMessages(cubit);
        }
      },
    );
  }

  Widget _buildSearchResults(MessagesCubit cubit) {
    return FutureBuilder<List<UserChatEntity>>(
      future: cubit.searchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding:
                EdgeInsetsDirectional.only(start: 12.w, top: 8.h, end: 13.w),
            child: const ShimmerUserCard(),
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                MessageCard(chat: snapshot.data![index]),
          );
        }
        return const NoUsersFound();
      },
    );
  }

  Widget _buildChatMessages(MessagesCubit cubit) {
    return StreamBuilder<List<UserChatEntity>>(
      stream: cubit.getUsersChats(),
      builder: (context, snapshot) {
        return ConditionalBuilder(
          condition: snapshot.hasData,
          builder: (context) => snapshot.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      MessageCard(chat: snapshot.data![index]),
                )
              : const NoMessagesYet(),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 1.2)),
        );
      },
    );
  }
}
