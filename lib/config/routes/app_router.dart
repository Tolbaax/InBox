import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/functions/deep_link_listener.dart';
import 'package:inbox/presentation/controllers/user/user_cubit.dart';
import 'package:inbox/presentation/view/home/widgets/deep_link_post.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/injection/injector.dart';
import '../../core/utils/app_strings.dart';
import '../../data/datasources/auth/local/auth_local_data_source.dart';
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
import 'app_routes.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    final firebaseAuth = sl<FirebaseAuth>();

    // Check user authentication before generating routes
    if (settings.name == Routes.initialRoute) {
      // If the user is logged in, navigate to layout, otherwise to login
      final isAuthenticated = sl<AuthLocalDataSource>().getUser() != null &&
          firebaseAuth.currentUser != null;

      return isAuthenticated ? _navigateToLayout() : _navigateToLogin();
    }

    switch (settings.name) {
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
            child: const DeepLinkListener(child: LayoutScreen()),
          ),
        );

      case Routes.profile:
        final fromSearch = settings.arguments as bool;
        return PageTransition(
          type: fromSearch
              ? PageTransitionType.fade
              : PageTransitionType.rightToLeft,
          child: BlocProvider.value(
              value: sl<UserCubit>(),
              child: ProfileScreen(fromSearch: fromSearch)),
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
        final String imageUrl = arguments['imageUrl'];
        return PageTransition(
          type: PageTransitionType.fade,
          curve: Curves.ease,
          child: ChatScreen(uID: uId, name: name, imageUrl: imageUrl),
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
          builder: (_) => SendingImageViewPage(
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
          builder: (_) => SendingVideoViewPage(
            path: path,
            receiverId: uId,
            name: name,
            videoFile: videoFile,
          ),
        );

      case Routes.deepLinkPost:
        final arguments = settings.arguments as String;
        final String postID = arguments;
        return PageTransition(
          type: PageTransitionType.fade,
          curve: Curves.ease,
          child: DeepLinkPostScreen(postID: postID),
        );

      default:
        return undefinedRoute();
    }
  }

  // Helper methods for navigation
  static MaterialPageRoute _navigateToLayout() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => LayoutCubit(),
        child: const DeepLinkListener(child: LayoutScreen()),
      ),
    );
  }

  static MaterialPageRoute _navigateToLogin() {
    return MaterialPageRoute(
      builder: (context) => const SignInScreen(),
    );
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text(AppStrings.noRouteFound),
            ),
          )),
    );
  }
}
