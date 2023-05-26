import 'package:flutter/material.dart';
import 'package:shop_app_/custom.dart';

class AccountListTile extends StatelessWidget {
  AccountListTile({Key? key, required this.title, required this.icon})
      : super(key: key);
  String title;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            onTap: () {},
            title: Text(
              title,
              style: custom.mainstyle,
            ),
            leading: Icon(icon,color: Colors.black,),
            trailing: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 1,
        )
      ],
    );
  }
}
