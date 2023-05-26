import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shop_app_/screens/onbording_screen.dart';
import 'package:shop_app_/transtion/animated_navigation.dart';

// ignore: camel_case_types
class splash_screen extends StatefulWidget {
  splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  bool isVisible = false;
  bool isStart = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 6), (() {
      setState(() {
        isVisible = true;
      });
    }));
    Future.delayed(const Duration(seconds: 2), (() {
      setState(() {
        isStart = true;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(83, 177, 117, 1),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: isVisible ? 1 : 0,
            duration: const Duration(milliseconds: 1300),
            child: SizedBox(
                height: 60,
                child: Image.asset(
                  "images/logo.png",
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(isStart)
                    AnimatedTextKit(
                        onFinished: () {
                       //   Future.delayed( const Duration(seconds: 2), (() {
                            AnimatedNavigation.pushReplacement(context, const OnbordingScreen());
                         // }));
                       },
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText("nectar",
                              cursor: "",
                              speed: const Duration(milliseconds: 500),
                              textStyle: const TextStyle(
                                  fontSize: 70, color: Colors.white),
                              textAlign: TextAlign.center),
                        ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(isStart)
                    AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText("o n l i n e  g r o c r i e t",
                              cursor: "",
                              speed: const Duration(milliseconds: 140),
                              textStyle: const TextStyle(
                                  fontSize: 19, color: Colors.white),
                              textAlign: TextAlign.start),
                        ]),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
