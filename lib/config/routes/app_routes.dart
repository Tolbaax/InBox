import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/services/injection_container.dart';
import '../../core/utils/app_strings.dart';
import '../../presentation/components/post_item/comment/comment_screen.dart';
import '../../presentation/controllers/layout/layout_cubit.dart';
import '../../presentation/controllers/post/add_post/add_post_cubit.dart';
import '../../presentation/controllers/post/comment/comment_cubit.dart';
import '../../presentation/view/add_post/add_post_screen.dart';
import '../../presentation/view/chats/screens/camera_screen.dart';
import '../../presentation/view/chats/screens/chat_screen.dart';
import '../../presentation/view/chats/widgets/camera/sending_image_view_page.dart';
import '../../presentation/view/chats/widgets/camera/sending_video_view_page.dart';
import '../../presentation/view/forget_password/forget_password_screen.dart';
import '../../presentation/view/layout/layout_screen.dart';
import '../../presentation/view/login/screens/login_screen.dart';
import '../../presentation/view/profile/screens/edit_profile_screen.dart';
import '../../presentation/view/profile/screens/profile_screen.dart';
import '../../presentation/view/register/screens/signup_screen.dart';
import '../../presentation/view/settings/screens/confirm_delete_account_screen.dart';
import '../../presentation/view/settings/screens/delete_account_screen.dart';
import '../../presentation/view/settings/screens/drafts_screen.dart';
import '../../presentation/view/settings/screens/settings_screen.dart';
import '../../presentation/view/splash/splash_screen.dart';


class Routes {
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPass = '/forgetPass';
  static const String layout = '/layout';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String addPost = '/addPost';
  static const String comment = '/comment';
  static const String drafts = '/drafts';
  static const String deleteAccount = '/deleteAccount';
  static const String confirmDeleteAccount = '/confirmDeleteAccount';
  static const String chat = '/chat';
  static const String camera = '/camera';
  static const String sendingImageViewRoute = '/sending-image-view';
  static const String sendingVideoViewRoute = '/sending-video-view';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const SplashScreen(),
        );

      case Routes.login:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SignInScreen(),
        );

      case Routes.register:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const SignUpScreen(),
        );

      case Routes.forgetPass:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const ForgetPasswordScreen(),
        );

      case Routes.layout:
        return PageTransition(
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => LayoutCubit(),
            child: const LayoutScreen(),
          ),
        );

      case Routes.profile:
        final fromSearch = settings.arguments as bool;
        return PageTransition(
          type: fromSearch
              ? PageTransitionType.fade
              : PageTransitionType.rightToLeft,
          child: ProfileScreen(fromSearch: fromSearch),
        );

      case Routes.settings:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: BlocProvider(
            create: (context) => LayoutCubit(),
            child: const SettingsScreen(),
          ),
        );

      case Routes.editProfile:
        return PageTransition(
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: const SettingsScreen(),
          child: const EditProfileScreen(),
        );

      case Routes.addPost:
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: BlocProvider(
            create: (context) => AddPostCubit(sl()),
            child: const AddPostScreen(),
          ),
        );

      case Routes.comment:
        final String postID = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: BlocProvider(
            create: (context) => CommentCubit(sl(), sl()),
            child: CommentScreen(postID: postID),
          ),
        );

      case Routes.drafts:
        return PageTransition(
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: const SettingsScreen(),
          child: const DraftsScreen(),
        );

      case Routes.deleteAccount:
        return PageTransition(
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: const SettingsScreen(),
          child: const DeleteAccountScreen(),
        );

      case Routes.confirmDeleteAccount:
        return PageTransition(
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: const DeleteAccountScreen(),
          child: const ConfirmDeleteAccountScreen(),
        );

      case Routes.chat:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String uId = arguments['uId'];
        final String name = arguments['name'];
        return PageTransition(
          type: PageTransitionType.fade,
          curve: Curves.ease,
          child: ChatScreen(uID: uId, name: name),
        );

      case Routes.camera:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String uId = arguments['uId'];
        final String name = arguments['name'];
        return MaterialPageRoute(
          builder: (_) => CameraScreen(receiverId: uId, name: name),
        );

      case Routes.sendingImageViewRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String uId = arguments['uId'];
        final String path = arguments['path'];
        final String name = arguments['name'];
        final File imageFile = arguments['imageFile'];
        return MaterialPageRoute(
          builder: (_) =>
              SendingImageViewPage(
                path: path,
                receiverId: uId,
                name: name,
                imageFile: imageFile,
              ),
        );

      case Routes.sendingVideoViewRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        final String uId = arguments['uId'];
        final String path = arguments['path'];
        final String name = arguments['name'];
        final File videoFile = arguments['videoFile'];
        return MaterialPageRoute(
          builder: (_) =>
              SendingVideoViewPage(
                path: path,
                receiverId: uId,
                name: name,
                videoFile: videoFile,
              ),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) =>
      const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      )),
    );
  }
}
