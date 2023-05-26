import 'package:flutter/material.dart';
import 'package:shop_app_/custom.dart';

class MyExoansionTile extends StatelessWidget {
  MyExoansionTile({Key? key, required this.title, required this.child})
      : super(key: key);
  String title, child;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.black,
      iconColor: Colors.black,
      title: Text(
       title,
        style: custom.mainstyle,
      ),
      expandedAlignment: Alignment.bottomLeft,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                child,
                style: custom.discribionStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
