import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../core/injection/injector.dart';
import '../../../core/shared/common.dart';
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
  bool isConnected = true;
  Timer? _debounce; // Timer for debounce

  @override
  void initState() {
    super.initState();
    _initializeInternetCheck();
  }

  // Function to check internet connection on screen init
  void _initializeInternetCheck() async {
    isConnected = await checkInternetConnectivity();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = searchController.text.trim();

    final firestore = sl<FirebaseFirestore>();

    // Firestore query to search for users by username
    final usernameQuery = firestore
        .collection('users')
        .orderBy('username')
        .startAt([searchQuery]).endAt(["$searchQuery\uf8ff"]).get();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0.sp,
        title: SearchField(
          controller: searchController,
          hintText: AppStrings.searchForaUser,
          isTextFieldEmpty: isTextFieldEmpty,
          onChanged: (value) {
            if (_debounce?.isActive ?? false) {
              _debounce?.cancel(); // Cancel the previous timer
            }
            _debounce = Timer(const Duration(milliseconds: 400), () {
              // 400 ms debounce
              setState(() {
                isTextFieldEmpty = value.isNotEmpty;
              });
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
        child: isConnected
            ? FutureBuilder<QuerySnapshot>(
                future: usernameQuery,
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
              )
            : const CheckInternetConnection(child: SizedBox()),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _debounce?.cancel();
  }
}
