import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieTransition extends PageRouteBuilder {
  final Widget page;
  final String animationUrl;

  LottieTransition({required this.page, required this.animationUrl})
      : super(
    transitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Stack(
        children: <Widget>[
          Positioned.fill(
            child: Lottie.asset(
              animationUrl,
              fit: BoxFit.cover,
              frameRate: FrameRate.max,
              repeat: false,
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        ],
      );
    },
  );
}
