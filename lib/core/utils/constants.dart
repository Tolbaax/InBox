import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inbox/presentation/controllers/post/post_cubit.dart';
import 'package:inbox/presentation/controllers/user/user_cubit.dart';
import '../../presentation/view/chats/screens/messages_screen.dart';
import '../../presentation/view/home/screens/home_screen.dart';
import '../../presentation/view/profile/screens/profile_screen.dart';
import '../../presentation/view/search/search_screen.dart';
import '../injection/injector.dart';
import 'app_strings.dart';

class Constants {
  static List<Widget> screens = [
    BlocProvider.value(value: sl<PostCubit>(), child: const HomeScreen()),
    const SearchScreen(),
    const MessagesScreen(),
    BlocProvider.value(
        value: sl<UserCubit>(), child: const ProfileScreen(fromSearch: false)),
  ];

  static final iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.commentDots,
    FontAwesomeIcons.user,
  ];

  static final titles = <String>[
    AppStrings.home,
    AppStrings.search,
    AppStrings.chats,
    AppStrings.profile,
  ];

  static Gradient shimmerGradient = LinearGradient(
    colors: [
      Colors.grey[400]!,
      Colors.grey[200]!,
      Colors.grey[300]!,
    ],
    begin: const Alignment(-1, -1),
    end: const Alignment(1, 1),
    stops: const [0.4, 0.5, 0.6],
  );
}
