import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AnimatedNavigation {
  static void animatedPush(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageTransition(
        child: screen,
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 300)));
  }

  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        child: screen,
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 300))
      );
  }
}
