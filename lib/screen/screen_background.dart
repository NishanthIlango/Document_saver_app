import 'package:flutter/material.dart';

class ScreenBackgroundWidget extends StatelessWidget {
  final Widget child;
  const ScreenBackgroundWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Color(0xFF1e5376)
            ]),
      ),
      child: child,
    );
  }
}
