
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

// ignore: non_constant_identifier_names
void MyToast(String msg,BuildContext context){
  ToastContext().init(context);
  Toast.show(msg,duration: 2,gravity: Toast.bottom);
}