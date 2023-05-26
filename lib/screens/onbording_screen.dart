
import 'package:flutter/material.dart';
import 'package:shop_app_/screens/log_in.dart';
import 'package:shop_app_/screens/sign_in.dart';
import 'package:shop_app_/transtion/animated_navigation.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({Key? key}) : super(key: key);
  static String routeName = "";
  @override
  
  Widget build(BuildContext context) {
    double heightOfScreen = MediaQuery.of(context).size.height;
    double widthOfScreen = MediaQuery.of(context).size.height;
   // print(heightOfScreen);
    return Scaffold(
      body: Stack(
          children: [
            Container(
               decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("images/back_ground.png"),fit: BoxFit.cover,)
               ),
              
            ),
            Center(
              child: Padding(
                padding:  EdgeInsets.only(bottom: heightOfScreen / 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                 
                  children: [
                    Image.asset("images/logo.png"),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      '  Welcome  \n to our store',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text("get your groceries in as fast as an hour",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                        width: 350,
                        height: 80,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(83, 177, 117, 1),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ))),
                            onPressed: () {
                             AnimatedNavigation.animatedPush(context,  LogIn());
                            },
                            child: const Text(
                              "Get Started",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      
    );
  }
}
