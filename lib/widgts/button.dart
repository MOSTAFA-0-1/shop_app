import 'package:flutter/material.dart';
import 'Price_Text/price_text.dart';

class CartButton extends StatelessWidget {
  CartButton({Key? key, required this.function, required this.text})
      : super(key: key);
  Function function;
  String text;
  @override
  Widget build(BuildContext context) {
    print("rebuild screen");
    return Stack(children: [
      SizedBox(
        width: 350,
        height: 80,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(83, 177, 117, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ))),
            onPressed: () => function(),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 22,
              ),
            )),
      ),
      // ignore: unrelated_type_equality_checks

      const Positioned(right: 10, bottom: 35, child: PriceText())
    ]);
  }
}

class BasedButton extends StatelessWidget {
  BasedButton(
      {Key? key,
      required this.function,
      required this.text,
      this.color,
      this.iconData})
      : super(key: key);
  Function function;
  String text;
  Color? color;
  IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: 350,
        height: 80,
        child: Stack(fit: StackFit.expand, children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  color ?? const Color.fromRGBO(83, 177, 117, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ))),
            onPressed: () => function(),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          if (iconData != null)
            Positioned(
                left: 30,
                top: 20,
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.white,
                ))
        ]),
      ),
    ]);
  }
}
