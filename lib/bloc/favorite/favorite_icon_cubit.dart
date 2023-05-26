import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/bloc/user/current_user.dart';
import 'package:shop_app_/custom.dart';
import '../../widgts/toast.dart';

class FavoriteIconCubit extends Cubit<FavoriteIconSates> {
  FavoriteIconCubit() : super(Init());

  void setbool(String title, bool bol) {
    custom.pref!.setBool(title, bol);
  }

  void getbool(String title, BuildContext context) {
    if (!custom.pref!.containsKey("${CurrentUser.id}$title")) {
      custom.getBloc(context).setFavoriteItem();
      setbool("${CurrentUser.id}$title", true);
      MyToast("Added To Favorites", context);
    } else {
      if (custom.pref!.getBool("${CurrentUser.id}$title") == true) {
        custom.getBloc(context).deletFavoriteItem();
        setbool("${CurrentUser.id}$title", false);
        MyToast("Deleted", context);
      } else {
        custom.getBloc(context).setFavoriteItem();
        setbool("${CurrentUser.id}$title", true);
        MyToast("Added To Favorites", context);
      }
    }
    emit(Rebuild());
  }


 void rebuild(){
  emit(Rebuild());
 }

}

abstract class FavoriteIconSates {}

class Init extends FavoriteIconSates {}

class Rebuild extends FavoriteIconSates {}
