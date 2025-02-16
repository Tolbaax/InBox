import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../config/routes/app_routes.dart';
import '../injection/injector.dart';
import 'navigator.dart';

class DeepLinkListener extends StatefulWidget {
  final Widget child;

  const DeepLinkListener({super.key, required this.child});

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  @override
  void initState() {
    final appLinks = AppLinks(); // AppLinks is singleton

    // Subscribe to all events (initial link and further)
    appLinks.uriLinkStream.listen((uri) => _handleDeepLink(uri));

    super.initState();
  }

  void _handleDeepLink(Uri uri) {
    final firebaseAuth = sl<FirebaseAuth>();
    final pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      switch (pathSegments.first) {
        case 'profile':
          if (pathSegments.length > 1) {
            final userId = pathSegments[1];
            final isMe = userId == firebaseAuth.currentUser!.uid;
            isMe
                ? navigateTo(context, Routes.profile, arguments: true)
                : navigateToUserProfile(context: context, uID: userId);
          }
          break;
        case 'post':
          if (pathSegments.length > 1) {
            final postId = pathSegments[1];
            navigateTo(context, Routes.deepLinkPost, arguments: postId);
          }
          break;
        default:
          debugPrint('Unknown deep link: $uri');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
