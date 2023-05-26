import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_/bloc/user/current_user.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/widgts/button.dart';
import 'package:shop_app_/widgts/empity_icon_scaling.dart';
import 'package:shop_app_/widgts/widget02.dart';

import '../responsive/screen_size.dart';

class Favourites extends StatelessWidget {
  Favourites({Key? key}) : super(key: key);
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic> item = {};
  bool isIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  "Favourite",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
                height: 2,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.grey.shade400,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * .73,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: custom
                        .getBloc(context)
                        .store
                        .collection("users")
                        .doc(CurrentUser.id)
                        .collection("favorites")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircleAvatar(),
                        );
                      }

                      if (snapshot.data!.size == 0) {
                        return const Center(
                          child: AnimatedEmptyIcon()
                          
                        );
                      } else {
                        snapshot.data!.docs.map((element) {
                          item = element.data() as Map<String, dynamic>;
                          if (items.isEmpty) {
                            items.add(item);
                          } else {
                            for (int i = 0; i < items.length; i++) {
                              if (items[i]["title"] == item["title"]) {
                                isIn = true;
                                break;
                              } else {
                                isIn = false;
                              }
                            }
                            if (!isIn) {
                              items.add(item);
                            }
                          }
                        }).toList();

                        return AnimationLimiter(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                      horizontalOffset: index % 2 == 0
                              ? -ScreenSize.width!
                              : ScreenSize.width,
                                      duration: Duration(
                                          milliseconds: index + 1 * 400),
                                      child: FadeInAnimation(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: ExpansionTile(
                                            textColor: Colors.black,
                                            title: Text(
                                              items[index]["title"],
                                              style: custom.mainstyle,
                                            ),
                                            subtitle:
                                                Text(items[index]["brand"]),
                                            childrenPadding:
                                                const EdgeInsets.only(
                                                    left: 15, top: 10),
                                            leading: SizedBox(
                                                height: 100,
                                                width: 50,
                                                child: Image.network(
                                                  items[index]["images"][0],
                                                  fit: BoxFit.fill,
                                                )),
                                            trailing: Text(
                                                "${items[index]["price"]}\$"),
                                            children: [
                                              Text(
                                                items[index]["description"],
                                                style: custom.discribionStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      )));
                            },
                          ),
                        );
                      }
                    },
                  )),
            ),
            BasedButton(
                function: () {
                  for (var i = 0; i < items.length; i++) {
                    custom.getBloc(context).setCartItem(context, items[i]);
                    custom
                        .getBloc(context)
                        .deleteFavoriteItem(items[i]["title"]);
                  }
                },
                text: "Add All To Cart"),
          ],
        ),
      )),
    );
  }
}
