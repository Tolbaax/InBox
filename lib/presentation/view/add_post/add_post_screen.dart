import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/buttons/appbar_back_button.dart';
import '../../components/common/user_not_logged.dart';
import '../../controllers/user/user_cubit.dart';
import 'widgets/add_post_appbar.dart';
import 'widgets/add_post_draggable_sheet.dart';
import 'widgets/add_post_header.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEntity = UserCubit.get(context).userEntity;

    if (user == null || userEntity == null) {
      return Scaffold(
        appBar: AppBar(leading: const AppBarBackButton()),
        body: const UserNotLogged(),
      );
    }

    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AddPostAppBar(),
      body: Stack(
        children: [
          // Main content goes here
          AddPostHeader(),

          // The draggable scrollable sheet
          AddPostDraggableSheet(),
        ],
      ),
    );
  }
}
