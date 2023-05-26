import 'package:flutter/material.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/screens/explore_details.dart';

import '../transtion/animated_navigation.dart';

class ExploreItem extends StatelessWidget {
  ExploreItem(
      {Key? key, required this.color, required this.title, required this.url})
      : super(key: key);
  Color color;
  String url;
  String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AnimatedNavigation.animatedPush(context, ExploreDetails(id: title));
      },
      child: Container(
        width: 180,
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(20),
            color: color.withOpacity(.4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 140,
              height: 120,
              child: url == "images/impty_bag.jpg"
                  ? Image.asset(
                      url,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 120,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
