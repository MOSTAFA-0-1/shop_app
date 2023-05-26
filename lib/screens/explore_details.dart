import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/widgts/explore_details_small_screen.dart';
import 'package:shop_app_/widgts/new_item.dart';

class ExploreDetails extends StatelessWidget {
  ExploreDetails({Key? key, required this.id}) : super(key: key);
  static String route = "";
  String id;
  List<Map> items = [];
  int divison = 2;
  int itemCount = 0;
  Map item = {};
  bool isIn = false;
  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 20),
              child: Text(
                "Find Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Expanded(
                child: StreamBuilder(
              stream: custom
                  .getBloc(context)
                  .store
                  .collection("categorys")
                  .doc(id)
                  .collection("products")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircleAvatar(),
                  );
                }
                snapshot.data!.docs.map((element) {
                  item = element.data() as Map;
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
                itemCount = items.length;
                if (ScreenSize.width! <= 380) {
                  return ExploreDetailsSmallScreen.smallScreen(items);
                }

                return AnimationLimiter(
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 10,
                            childAspectRatio: .6,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 500),
                            verticalOffset: index % 2 == 0
                                ? ScreenSize.height
                                : -ScreenSize.height!,
                            child: FadeInAnimation(
                                child: NewItem(item: items[index])),
                          ));
                    },
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
