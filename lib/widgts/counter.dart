import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop_app_/custom.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:shop_app_/refrence.dart';

class Counter extends StatefulWidget {
  Counter({Key? key, required this.counter, this.function}) : super(key: key);
  Ref counter;
  Function? function;
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        custom.button(Icons.remove, Colors.grey, () {
          if (widget.counter.value > 1) {
            setState(() {
              widget.counter.value--;
             
            });
             if (widget.function != null) {
                widget.function!();
              }
          }
        }),
        AnimatedFlipCounter(
          value: widget.counter.value,
          textStyle: const TextStyle(
            fontSize: 25,
          ),
        ),
        custom.button(Icons.add, const Color.fromARGB(255, 81, 154, 84), () {
          setState(() {
            widget.counter.value++;
            if (widget.function != null) {
              widget.function!();
            }
          });
        }),
      ],
    );
  }
}
