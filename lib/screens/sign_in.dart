// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // ignore: must_be_immutable
// class SignIn extends StatelessWidget {
//   SignIn({Key? key}) : super(key: key);

//   var user;

//   void googleSignIN() async {
//     final googleacount = await GoogleSignIn().signIn();
//     if (googleacount != null) {
//       final gAuth = await googleacount.authentication;
//       if (gAuth.idToken != null && gAuth.accessToken != null) {
//         try {
//           await GoogleAuthProvider.credential(
//               idToken: gAuth.idToken, accessToken: gAuth.accessToken);
//         } on FirebaseAuthException catch (e) {
//           print(e.message);
//         } catch (e) {
//           print(e);
//         } finally {}
//       }
//     }
//   }
//   // void signInWithGoogle() async {
//   //   // Trigger the authentication flow
//   //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   //   // Obtain the auth details from the request
//   //   final GoogleSignInAuthentication? googleAuth =
//   //       await googleUser?.authentication;

//   //   // Create a new credential
//   //   final credential = GoogleAuthProvider.credential(
//   //     accessToken: googleAuth?.accessToken,
//   //     idToken: googleAuth?.idToken,
//   //   );

//   //   // Once signed in, return the UserCredential
//   //   UserCredential result =
//   //       await FirebaseAuth.instance.signInWithCredential(credential);
//   //   user = result.user;
//   // }

//   static String routeName = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(
//                 "images/Mask_Group.png",
//                 height: MediaQuery.of(context).size.height / 2.5,
//                 width: double.infinity,
//               ),
//               const Text(
//                 "Get tour groceries \n with nectar",
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                       label: Row(
//                     children: [
//                       Image.asset("images/flag.png"),
//                       const Text(
//                         "  +880",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                       ),
//                     ],
//                   )),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width / 4.5,
//                     top: 30,
//                     bottom: 50),
//                 child: const Text(
//                   "Or conect with social media",
//                   style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 10,
//                       width: MediaQuery.of(context).size.width * .91,
//                       child: socialListTile(
//                           function: () async {
//                             googleSignIN();
//                           },
//                           color: const Color.fromRGBO(83, 131, 236, 1),
//                           text: "Google",
//                           Url: "images/google icon.png",
//                           iconHeight: 30),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 10,
//                       width: MediaQuery.of(context).size.width * .91,
//                       child: socialListTile(
//                           function: () {},
//                           color: const Color.fromRGBO(74, 102, 172, 1),
//                           text: "Facebook",
//                           Url: "images/faceicon.png",
//                           iconHeight: 30),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   ListTile socialListTile(
//       {required String Url,
//       required String text,
//       required Color color,
//       required double iconHeight,
//       required Function function}) {
//     return ListTile(
//       onTap: () => function(),
//       contentPadding: const EdgeInsets.only(top: 10, left: 5),
//       leading: Padding(
//           padding: const EdgeInsets.only(
//             left: 30,
//           ),
//           child: Image.asset(
//             Url,
//             height: iconHeight,
//           )),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//       title: Padding(
//         padding: const EdgeInsets.only(left: 10),
//         child: Text(
//           "Continue with $text",
//           style: const TextStyle(color: Colors.white, fontSize: 22),
//         ),
//       ),
//       tileColor: color,
//     );
//   }
// }
