import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/bloc/favorite/favorite_icon_cubit.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/screens/log_in.dart';
import 'package:shop_app_/widgts/button.dart';
import '../transtion/animated_navigation.dart';
import '../widgts/toast.dart';
import 'main_screen.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
              const Text(
                "Loging",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Enter your credential to continue",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    label: const Text("Username"),
                    focusColor: Theme.of(context).primaryColor),
                onChanged: ((value) {}),
              ),
              const SizedBox(
                height: 20,
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
                              BlocProvider.of<FavoriteIconCubit>(context)
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
              RichText(
                  text: const TextSpan(
                      style: TextStyle(fontSize: 17, color: Colors.black),
                      children: [
                    TextSpan(text: "By continuing yuo agree to our "),
                    TextSpan(
                        text: "Terms of service",
                        style: TextStyle(
                          color: Colors.green,
                        )),
                    TextSpan(text: "\nAnd "),
                    TextSpan(
                      text: "privacy policy",
                      style: TextStyle(color: Colors.green),
                    )
                  ])),
              const SizedBox(
                height: 40,
              ),
              BasedButton(
                  function: () {
                    if (emailController.text.isNotEmpty &&
                        passController.text.isNotEmpty &&
                        usernameController.text.isNotEmpty) {
                      try {
                        custom.auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passController.text)
                            .then((value) {
                              
                          custom.store
                              .collection("users")
                              .doc(value.user!.uid)
                              .set({"name": usernameController.text});
                          custom.pref!.setBool("isSignedIn", true);
                          AnimatedNavigation.pushReplacement(
                              context, MainScreen());
                        }).catchError(
                          (e) {
                            MyToast(e.toString(), context);
                          },
                          test: (error) {
                            return false;
                          },
                        );
                      } on FirebaseAuthException catch (e) {
                        MyToast(e.message!, context);
                      } catch (e) {
                        MyToast(e.toString(), context);
                      }
                    } else {
                      MyToast("please fill all required data", context);
                    }
                  },
                  text: "Sign Up"),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(fontSize: 20)),
                    TextButton(
                        onPressed: () {
                          AnimatedNavigation.pushReplacement(context, LogIn());
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
