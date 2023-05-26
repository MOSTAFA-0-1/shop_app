import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app_/bloc/user/current_user.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/screens/log_in.dart';
import 'package:shop_app_/widgts/account_list_tile.dart';
import 'package:shop_app_/widgts/button.dart';
import 'package:shop_app_/widgts/image_picker.dart';

import '../transtion/animated_navigation.dart';

class Account extends StatelessWidget {
  Account({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text =CurrentUser.name.toString();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const ImageContainer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, counterText: ""),
                          maxLength: 20,
                          controller: controller,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                          onChanged: (value) {
                            custom.store.collection("users").doc(CurrentUser.id).update({"name":controller.text});
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              for (int i = 0; i < 7; i++)
                AccountListTile(
                  title: "Help",
                  icon: Icons.help_outline_sharp,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: BasedButton(
                  function: () async {
                    await custom.auth.signOut().whenComplete(() {
                      custom.pref!.setBool("isSignedIn", false);
                      AnimatedNavigation.pushReplacement(
                          context,  LogIn());
                    });
                   
                  },
                  text: "Log Out",
                  iconData: Icons.logout,
                  color: const Color.fromARGB(255, 191, 190, 194),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
