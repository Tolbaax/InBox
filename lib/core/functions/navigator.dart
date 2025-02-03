import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../domain/entities/user_entity.dart';
import '../../presentation/view/profile/screens/user_profile_screen.dart';

void navigatePop(
  BuildContext context,
) {
  Navigator.of(context).pop();
}

void navigateAndRemove(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    routeName,
    arguments: arguments,
    (route) => false,
  );
}

Future<Object?> navigateTo(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  return Navigator.of(context).pushNamed(
    routeName,
    arguments: arguments,
  );
}

void navigateAndReplace(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  Navigator.of(context).pushReplacementNamed(
    routeName,
    arguments: arguments,
  );
}

navigateToUserProfile(BuildContext context, UserEntity user, bool fromSearch) {
  Navigator.of(context).push(
    PageTransition(
      type:
          fromSearch ? PageTransitionType.fade : PageTransitionType.rightToLeft,
      child: UserProfile(user: user),
    ),
  );
}
