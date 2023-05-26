import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/screens/main_screen.dart';
import 'package:shop_app_/screens/sign_up.dart';
import 'package:shop_app_/widgts/button.dart';
import 'package:shop_app_/widgts/toast.dart';
import '../bloc/favorite/favorite_icon_cubit.dart';
import '../responsive/screen_size.dart';
import '../transtion/animated_navigation.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);
  static String routeName = "";

  bool isHidden = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ScreenSize.height! / 3.5,
                width: double.infinity,
                child: Center(
                  child: Image.asset(
                    "images/logo2.png",
                    height: 80,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Loging",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Enter your email and password",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            label: const Text("Email"),
                            focusColor: Theme.of(context).primaryColor),
                        onChanged: ((value) {}),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<FavoriteIconCubit, FavoriteIconSates>(
                        builder: (context, state) {
                          return TextField(
                            controller: passController,
                            obscureText: isHidden,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      isHidden = !isHidden;
                                      BlocProvider.of<FavoriteIconCubit>(
                                              context)
                                          .rebuild();
                                    },
                                    icon: isHidden
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility)),
                                label: const Text("Password"),
                                focusColor: Theme.of(context).primaryColor),
                            onChanged: ((value) {}),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Forget password?",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: BasedButton(
                            function: () async {
                              if (emailController.text.isNotEmpty &&
                                  passController.text.isNotEmpty) {
                                try {
                                  await custom.auth
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passController.text)
                                      .then((value) {
                                    custom.pref!.setBool("isSignedIn", true);

                                    AnimatedNavigation.pushReplacement(
                                        context, MainScreen());
                                  });
                                } on FirebaseAuthException catch (e) {
                                  MyToast(e.message!, context);
                                } catch (e) {
                                  MyToast(e.toString(), context);
                                }
                              } else {
                                MyToast(
                                    "please fill all required data", context);
                              }
                            },
                            text: "Log In"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(" Don't have an account?",
                                style: TextStyle(fontSize: 20)),
                            TextButton(
                                onPressed: () {
                                  AnimatedNavigation.pushReplacement(
                                      context, SignUp());
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
