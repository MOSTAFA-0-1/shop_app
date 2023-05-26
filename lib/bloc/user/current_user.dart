import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app_/custom.dart';

class CurrentUser {
  static String? name,id,url;
 static void serURL(String imageurl){
  url = imageurl;
 }
//   static getCurrentUser() async {
//     await Future.delayed(const Duration(seconds: 2));
//     currentUser = custom.auth.currentUser;
//     print(currentUser?.uid);
//   }
//  static Future<void> initializeUser() async {
//     FirebaseAuth.instance.authStateChanges().listen(
//       (User? user) async {
//         if (user == null) {
//           print('user is signed out');
//         } else {
//           print('user has signed in');
//         }
//       },
//     );
//   }
}
