import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/refrence.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/widgts/Price_Text/price_text_cubit.dart';
import 'package:shop_app_/widgts/counter.dart';

class CartItem extends StatelessWidget {
  CartItem({
    Key? key,
    required this.url,
    required this.title,
    required this.discribion,
    required this.price,
    required this.counter,
  }) : super(key: key);
  String url, title, discribion;
  double price;
  Ref counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  url,
                  height: ScreenSize.width! / 5,
                  width: ScreenSize.width! / 5,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.only(left: ScreenSize.width! / 30),
                  child: SizedBox(
                    width: 170,
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: title,
                            style: custom.mainstyle,
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          discribion,
                          style: custom.discribionStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Counter(
                          counter: counter,
                          function: () {
                            custom
                                .getBloc(context)
                                .updateCounter(title, counter.value);

                            custom.getTextBloc(context).getPriceText(custom
                                .getBloc(context)
                                .getCartTotalPrice()
                                .toString());
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: ScreenSize.width! / 30, bottom: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          custom
                              .getBloc(context)
                              .deleteCartitem(title, (price * counter.value));
                          BlocProvider.of<PriceTextCubit>(context).getPriceText(
                              custom
                                  .getBloc(context)
                                  .cartTotalPrice
                                  .toString());
                        },
                        icon: const Icon(Icons.cancel_rounded),
                      ),
                      Text(
                        "${price}\$",
                        style: TextStyle(
                            fontSize: ScreenSize.width! / 23,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(
          endIndent: 30,
          indent: 40,
          height: 2,
          color: Colors.grey,
        )
      ],
    );
  }
}
