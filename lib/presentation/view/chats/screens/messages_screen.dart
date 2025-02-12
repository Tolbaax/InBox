import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/data/models/user_chat_model.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';
import 'package:inbox/presentation/controllers/messages/messages_states.dart';
import 'package:inbox/presentation/view/chats/widgets/messages/message_app_bar.dart';
import '../../../../../core/shared/common.dart';
import '../../../../core/injection/injector.dart';
import '../../search/widgets/no_users_found.dart';
import '../../search/widgets/shimmer_user_card.dart';
import '../widgets/messages/message_card.dart';
import '../widgets/messages/no_messages_yet.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MessageAppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final cubit = sl<MessagesCubit>();

    final searchQuery = convertToTitleCase(cubit.searchController.text.trim());

    final firestore = sl<FirebaseFirestore>();
    final firebaseAuth = sl<FirebaseAuth>();

    final searchFuture = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .orderBy('name')
        .startAt([searchQuery]).endAt(["${searchQuery}uf8ff"]);

    return BlocProvider.value(
      value: sl<MessagesCubit>(),
      child: BlocConsumer<MessagesCubit, MessagesStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return Padding(
            padding: EdgeInsetsDirectional.only(top: 4.0.sp),
            child: searchQuery.isEmpty
                ? chatMessagesBody(context)
                : FutureBuilder<QuerySnapshot>(
                    future: searchFuture.get(),
                    builder: (context, snapshot) {
                      // Connection is waiting
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          cubit.isTextFieldEmpty &&
                          !snapshot.hasError) {
                        return ShimmerUserCard(snapshot: snapshot);
                      }

                      // No Users Found
                      if (cubit.searchController.text.isNotEmpty &&
                          snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.docs.isEmpty) {
                        return const NoUsersFound();
                      }

                      // Users Found Successfully
                      if (snapshot.hasData &&
                          cubit.searchController.text.isNotEmpty &&
                          cubit.isTextFieldEmpty &&
                          searchQuery.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            UserChatEntity chat = UserChatModel.fromJson(
                                data.data() as Map<String, dynamic>);

                            return MessageCard(chat: chat);
                          },
                        );
                      }

                      // User not searched yet
                      return const NoMessagesYet();
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget chatMessagesBody(BuildContext context) {
    return StreamBuilder<List<UserChatEntity>>(
      stream: sl<MessagesCubit>().getUsersChats(),
      builder: (context, snapshot) {
        return ConditionalBuilder(
          condition: snapshot.hasData,
          builder: (context) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return buildChatListView(snapshot.data!);
            } else {
              return const NoMessagesYet();
            }
          },
          fallback: (context) => Center(
            child: snapshot.hasError
                ? const NoMessagesYet()
                : const CircularProgressIndicator(strokeWidth: 1.2),
          ),
        );
      },
    );
  }

  ListView buildChatListView(List<UserChatEntity> data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final chat = data[index];
        return MessageCard(chat: chat);
      },
    );
  }
}
