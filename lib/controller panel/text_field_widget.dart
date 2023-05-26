import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
   MyTextForm({Key? key,required this.title,required this.function}) : super(key: key);
  Function(String value) function;
String title;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
            decoration: const InputDecoration(
              hintText: "Title"
            ),
            onChanged: (value) =>  function(value),
          );
  }
}

class MyDigitalTextForm extends StatelessWidget {
   MyDigitalTextForm({Key? key,required this.title,required this.function}) : super(key: key);
  Function(double value) function;
String title;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
             keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Title",
            ),
            onChanged: (value){
              if (value != "") {
                function(double.parse(value));
              }
              
            }  ,
            
          );
  }
}