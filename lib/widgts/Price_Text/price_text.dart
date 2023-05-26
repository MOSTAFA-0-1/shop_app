import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/widgts/Price_Text/price_text_cubit.dart';
import 'package:shop_app_/widgts/Price_Text/price_text_state.dart';

class PriceText extends StatelessWidget {
  const PriceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceTextCubit,TextState>(builder: (context, state) {
       return Text(
           state.priceText == "0.0"?"": "${state.priceText}\$",
            style: const TextStyle(color: Colors.white),
          );
    },);
  }
}