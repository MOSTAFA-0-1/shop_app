import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/transtion/animated_navigation.dart';

import '../bloc/cubit.dart';
import '../screens/details.dart';

class NewItem extends StatelessWidget {
  NewItem(
      {Key? key,
     required this.item
     })
      : super(key: key);
  // String imageUrl;
  // String itemName;
  // String discribtion;
  // double price;
  Map item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
           BlocProvider.of<MainCubit>(context).SetItemDetails(item as Map<String,dynamic>);
           AnimatedNavigation.animatedPush(context, Details());
        },
        child: Container(
          height: ScreenSize.height! * 0.4,
          width: ScreenSize.width! / 2.2,
          decoration: BoxDecoration(
              // color: Colors.redAccent,
              border: Border.all(color: Colors.grey, width: .7),
              borderRadius: BorderRadius.circular(25)),
          child: LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: constraints.minHeight / 2.2,
                      width: double.infinity,
                      child: Center(child: Image.network( item["images"][0],))),
                  Text(
                    item["title"],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                  ),
                  Text(
                 "${ item["brand"]}"  ,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${item["price"]}\$",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(50, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(83, 177, 117, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15)))),
                          onPressed: () {
                            custom.getBloc(context).setCartItem(context, item as  Map<String, dynamic> );
                          },
                          child:  Icon(
                            Icons.add,
                            size: constraints.maxHeight / 10,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
