import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/data/models/user_chat_model.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import '../../../../../core/shared/common.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../components/text_fields/search_field.dart';
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
  final TextEditingController searchController = TextEditingController();
  bool isTextFieldEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 86.0.h,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.messages,
            style: TextStyle(fontSize: 20.0.sp),
          ),
          SizedBox(height: 12.0.h),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 4.0.w),
            child: SearchField(
              controller: searchController,
              hintText: AppStrings.search,
              isTextFieldEmpty: isTextFieldEmpty,
              onChanged: onSearchFieldChanged,
              suffixTap: clearSearchField,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final searchQuery = convertToTitleCase(searchController.text.trim());

    final searchFuture = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .orderBy('name')
        .startAt([searchQuery]).endAt(["${searchQuery}uf8ff"]);

    return Padding(
      padding: EdgeInsetsDirectional.only(
        end: 18.0.sp,
        start: 18.0.sp,
        top: 7.0.sp,
      ),
      child: searchQuery.isEmpty
          ? chatMessagesBody(context)
          : FutureBuilder<QuerySnapshot>(
              future: searchFuture.get(),
              builder: (context, snapshot) {
                // Connection is waiting
                if (snapshot.connectionState == ConnectionState.waiting &&
                    isTextFieldEmpty &&
                    !snapshot.hasError) {
                  return ShimmerUserCard(snapshot: snapshot);
                }

                // No Users Found
                if (searchController.text.isNotEmpty &&
                    snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.docs.isEmpty) {
                  return const NoUsersFound();
                }

                // Users Found Successfully
                if (snapshot.hasData &&
                    searchController.text.isNotEmpty &&
                    isTextFieldEmpty &&
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
  }

  Widget chatMessagesBody(BuildContext context) {
    return StreamBuilder<List<UserChatEntity>>(
      stream: ChatCubit.get(context).getUsersChats(),
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
                : CircularProgressIndicator(strokeWidth: 2.5.sp),
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

  void onSearchFieldChanged(value) {
    setState(() {
      isTextFieldEmpty = true;
    });
  }

  void clearSearchField() {
    setState(() {
      searchController.clear();
      isTextFieldEmpty = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
