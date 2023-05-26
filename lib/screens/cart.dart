import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_/bloc/user/current_user.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/refrence.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/widgts/button.dart';
import 'package:shop_app_/widgts/cart_item.dart';
import 'package:shop_app_/widgts/empity_icon_scaling.dart';

// ignore: must_be_immutable
class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);
  static String routename = "";
  double total = 0;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    i = 0;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: Text(
              "My Cart",
              style: custom.mainstyle,
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          Expanded(
              child: StreamBuilder(
            stream: custom
                .getBloc(context)
                .store
                .collection("users")
                .doc(CurrentUser.id)
                .collection("cart")
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
              }

              return AnimationLimiter(
                child: ListView(
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (listitem) {
                      return SlideAnimation(
                          horizontalOffset: i % 2 == 0
                              ? -ScreenSize.width!
                              : ScreenSize.width,
                          duration: Duration(milliseconds: ++i * 350),
                          child: FadeInAnimation(
                            child: listitem,
                          ));
                    },
                    children: snapshot.data!.docs.map(
                      (item) {
                        custom.getBloc(context).calcTotal(
                            item["title"],
                            double.parse(item["price"].toString()) *
                                item["counter"]);

                        custom.getTextBloc(context).getPriceText(custom
                            .getBloc(context)
                            .getCartTotalPrice()
                            .toString());

                        return CartItem(
                          url: item["images"][0],
                          title: item["title"],
                          discribion: item["brand"],
                          price: double.parse(item["price"].toString()),
                          counter: Ref(value: item["counter"]),
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CartButton(function: () {}, text: "Go To Checkout"),
          )
        ],
      ),
    );
  }
}
