import 'package:flutter/material.dart';

class AppBarGradient extends StatelessWidget {
  const AppBarGradient({super.key});

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white,
      Color.fromARGB(252, 250, 250, 250),
      Color.fromARGB(177, 250, 250, 250),
      Color(0x00FFFFFF),
    ],
    stops: [0.0, 0.65, 0.75, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
    );
  }
}
