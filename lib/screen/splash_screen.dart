import 'package:flutter/material.dart';
import 'package:wollu/util/app_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Center(
            child: Image.asset('assets/logo.png'),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/team_logo.png'),
            ),
          )
        ],
      ),
    );
  }
}
