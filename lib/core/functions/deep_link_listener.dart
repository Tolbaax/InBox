import 'dart:async';
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
  late final AppLinks appLinks;
  StreamSubscription<Uri?>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    appLinks = AppLinks();

    // Subscribe to deep link stream
    _linkSubscription = appLinks.uriLinkStream.listen((uri) {
      if (mounted) _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    if (!mounted) return; // Prevent using context after unmounting

    final firebaseAuth = sl<FirebaseAuth>();
    final pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      switch (pathSegments.first) {
        case 'profile':
          if (pathSegments.length > 1) {
            final userId = pathSegments[1];
            final isMe = userId == firebaseAuth.currentUser?.uid;
            if (isMe) {
              navigateTo(context, Routes.profile, arguments: true);
            } else {
              navigateToUserProfile(context: context, uID: userId);
            }
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
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
