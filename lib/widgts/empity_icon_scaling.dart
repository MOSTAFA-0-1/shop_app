import 'package:flutter/material.dart';

class AnimatedEmptyIcon extends StatefulWidget {
  const AnimatedEmptyIcon({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedEmptyIconState createState() => _AnimatedEmptyIconState();
}

class _AnimatedEmptyIconState extends State<AnimatedEmptyIcon>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.bounceInOut);

    _controller!.forward();
  }

  @override
  dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation!,
      alignment: Alignment.center,
      child: Image.asset(
        "images/empty_cart.png",
        fit: BoxFit.fill,
      ),
    );
  }
}
