import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/cubit.dart';
import 'widgts/Price_Text/price_text_cubit.dart';

class custom {
 static FirebaseFirestore store = FirebaseFirestore.instance;
 static FirebaseAuth auth = FirebaseAuth.instance;
  static TextStyle mainstyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle discribionStyle =
      const TextStyle(fontSize: 18, color: Colors.grey);

  static List data = [];
  static SharedPreferences? pref;
 static void intiialisePref() async {
    pref = await SharedPreferences.getInstance();
  }

  static ElevatedButton button(IconData icon, Color color, Function function) =>
      ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(50, 50)),
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 255, 255, 255),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
          onPressed: () => function(),
          child: Icon(
            icon,
            size: 30,
            color: color,
          ));
  static Divider divider = const Divider(
    endIndent: 30,
    indent: 40,
    height: 2,
    color: Colors.grey,
  );
  static MainCubit  getBloc(BuildContext context){
      return  BlocProvider.of<MainCubit>(context);
  }
   static MainCubit  getBlocListener(BuildContext context){
      return  BlocProvider.of<MainCubit>(context,listen: true);
  }
  static PriceTextCubit  getTextBloc(BuildContext context){
      return  BlocProvider.of<PriceTextCubit>(context);
  }
}
