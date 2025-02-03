import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_strings.dart';
import '../../components/internet/check_internet_connection.dart';
import 'widgets/no_users_found.dart';
import '../../components/text_fields/search_field.dart';
import 'widgets/search_for_users.dart';
import 'widgets/shimmer_user_card.dart';
import 'widgets/user_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  bool isTextFieldEmpty = false;

  @override
  Widget build(BuildContext context) {
    final searchQuery = (searchController.text.trim());

    final usernameFuture = FirebaseFirestore.instance
        .collection('users')
        .orderBy('username')
        .startAt([searchQuery]).endAt(["${searchQuery}uf8ff"]);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0.sp,
        title: SearchField(
          controller: searchController,
          hintText: AppStrings.searchForaUser,
          isTextFieldEmpty: isTextFieldEmpty,
          onChanged: (value) {
            setState(() {
              isTextFieldEmpty = true;
            });
          },
          suffixTap: () {
            setState(() {
              searchController.clear();
              isTextFieldEmpty = false;
            });
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          end: 18.0.sp,
          start: 18.0.sp,
          top: 7.0.sp,
        ),
        child: CheckInternetConnection(
          child: FutureBuilder<QuerySnapshot>(
            future: usernameFuture.get(),
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
                  isTextFieldEmpty &&
                  searchController.text.isNotEmpty &&
                  searchQuery.isNotEmpty) {
                return UserCard(snapshot: snapshot);
              }

              // User not searched yet
              return const SearchForUsers();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
