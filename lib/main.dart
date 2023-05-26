import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/bloc/cubit.dart';
import 'package:shop_app_/bloc/explor%20cubit/explore_cubit.dart';
import 'package:shop_app_/bloc/favorite/favorite_icon_cubit.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/screens/log_in.dart';
import 'package:shop_app_/screens/main_screen.dart';
import 'package:shop_app_/screens/onbording_screen.dart';
import 'package:shop_app_/screens/sign_in.dart';
import 'package:shop_app_/screens/splash.dart';
import 'package:shop_app_/widgts/Price_Text/price_text_cubit.dart';
import 'controller panel/add_item.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding();
  custom.intiialisePref();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MyApp(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Map dataMap = {};
  List data = [];
  getData() async {
    String url = "https://dummyjson.com/products";
    var response = await http.get(Uri.parse(url));
    var resbody = await jsonDecode(response.body);
    dataMap.addAll(resbody);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainCubit(),
        ),
        BlocProvider(
          create: (context) => ExploreCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteIconCubit(),
        ),
        BlocProvider(
          create: (context) => PriceTextCubit(),
        ),
        BlocProvider(
          create: (context) => ListImagesCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(83, 177, 117, 1),
          ),
          home: Builder(builder: (context) {
            ScreenSize.getScreenSize(MediaQuery.of(context).size.height,
                MediaQuery.of(context).size.width);
            // return LogIn();

            return custom.pref!.getBool("isSignedIn") == null
                ? splash_screen()
                : custom.pref!.getBool("isSignedIn")!
                    ? MainScreen()
                    : splash_screen();
          }),
          routes: {
            MainScreen.route: (context) => MainScreen(),
            "onBording": (context) => const OnbordingScreen(),
            LogIn.routeName: (context) =>  LogIn(),
          },
        );
      }),
    );
  }
}
