import 'package:flutter/material.dart';
class MyWidget extends StatefulWidget {
   MyWidget({Key? key,required this.children,required this.discription}) : super(key: key);
 List<Widget> children;
 String discription;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isHidden = true ;
  @override
  Widget build(BuildContext context) {
    return        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: widget.children ),
                  !isHidden
                      ? AnimatedOpacity(
                          opacity: !isHidden ? 1 : 0,
                          duration: const Duration(milliseconds: 700),
                          child:  Text(
                            widget.discription,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )
                      : Text(""),
                ],
              ),
            )
           ;
  }
}