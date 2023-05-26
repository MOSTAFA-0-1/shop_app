import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_/bloc/user/current_user.dart';

import 'package:shop_app_/custom.dart';
import 'package:shop_app_/screens/account_screen.dart';
import 'package:shop_app_/screens/cart.dart';
import 'package:shop_app_/screens/explor.dart';
import 'package:shop_app_/screens/favourite.dart';
import 'package:shop_app_/screens/home.dart';

import 'package:http/http.dart' as http;

import '../bloc/cubit.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  static String route = "";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List screens = [HomeScreen(), Explore(), Cart(), Favourites(), Account()];
  int index = 0;
  Map dataMap = {};
  List data = [];
  getData(BuildContext context) async {
    String url = "https://dummyjson.com/products";
    var response = await http.get(Uri.parse(url));
    var resbody = await jsonDecode(response.body);
    dataMap.addAll(resbody);
    custom.data.addAll(dataMap["products"]);
    // ignore: use_build_context_synchronously
  }

  FirebaseFirestore store = FirebaseFirestore.instance;
  test() {
    List categorys = [];
    bool isin = false;
    for (var i = 0; i < custom.data.length; i++) {
      for (var j = 0; j < categorys.length; j++) {
        if (categorys[j] == custom.data[i]["category"]) {
          isin = true;
          break;
        } else {
          isin = false;
        }
      }
      if (!isin) {
        categorys.add(custom.data[i]["category"]);
      }
    }
    print(custom.data.length);
    for (int k = 0; k < categorys.length; k++) {
      store.collection("categorys").doc(categorys[k]).set({
        "category": categorys[k],
        "url": custom.data[k]["images"][0]
      }).then((value) {
        List data = custom.data
            .where((element) => element["category"] == categorys[k])
            .toList();
        print(data.length);

        for (var j = 0; j < data.length; j++) {
          store
              .collection("categorys")
              .doc(categorys[k])
              .collection("products")
              .add(data[j]);
        }
      });
    }
  }

  getCurrentUserData() {
    CurrentUser.id = custom.auth.currentUser!.uid;
    custom.store.collection("users").doc(CurrentUser.id).get().then((value) {
      if (value.data()!["name"] != null) {
        CurrentUser.name = value.data()!["name"];
      }
      if (value.data()!["imageURL"] != null) {
        CurrentUser.url = value.data()!["imageURL"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //  print(custom.auth.currentUser!.email);
    // getData(context);
    // test();
    getCurrentUserData();
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("images/store.png")), label: "Shop"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("images/explore.png"),
                ),
                label: "Explore"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("images/cart.png")), label: "Cart"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("images/love.png")),
                label: "Favorite"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("images/person.png")),
                label: "Account"),
          ]),
    );
  }
}
