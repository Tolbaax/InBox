import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'no_internet_icon.dart';

class CheckInternetConnection extends StatelessWidget {
  final Widget child;

  const CheckInternetConnection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ConnectivityResult>>(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        final hasInternet = snapshot.data != null &&
            !snapshot.data!.contains(ConnectivityResult.none);

        return hasInternet ? child : const NoInternetIcon();
      },
    );
  }
}
