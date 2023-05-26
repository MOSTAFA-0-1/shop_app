import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/bloc/states.dart';
import 'package:shop_app_/bloc/user/current_user.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/widgts/toast.dart';
import '../refrence.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitialState());
  static MainCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore store = FirebaseFirestore.instance;
  List data = [];
  Map<String, dynamic> item = {};

  void setData(List info) {
    data.addAll(info);
  }

  List getData() {
    return data;
  }

  // ignore: non_constant_identifier_names
  void SetItemDetails(Map<String, dynamic> item) {
    this.item = item;
  }

  Map getItemDetails() {
    return item;
  }

  int increase(int num) {
    return num++;
  }

  int decrease(int num) {
    return num--;
  }

  bool exists = false;
  Future<void> setCartItem(
      BuildContext context, Map<String, dynamic> cartitem) async {
    await store
        .collection("users")
        .doc(CurrentUser.id)
        .collection("cart")
        .doc(cartitem["title"].toString())
        .get()
        .then((value) {
      exists = value.exists;
      if (exists) {
        cartitem = value.data()!;
        cartitem["counter"]++;
      }
    });
    if (!exists) {
      cartitem.addAll({"counter": 1});
    }
    store
        .collection("users")
        .doc(CurrentUser.id)
        .collection("cart")
        .doc(cartitem["title"].toString())
        .set(cartitem)
        .then((value) {});
    MyToast("Added", context);
  }

  void updateCounter(String id, int counter) {
    store
        .collection("users")
        .doc(CurrentUser.id)
        .collection("cart")
        .doc(id)
        .update({"counter": counter});
  }

  Map<String, dynamic> itemTotalPrice = {};
  double cartTotalPrice = 0;

  void deleteCartitem(String id, double itemprice) {
    if (cartTotalPrice > 0) {
      cartTotalPrice -= itemprice;
    }
    itemTotalPrice.remove(id);
    store
        .collection("users")
        .doc(CurrentUser.id)
        .collection("cart")
        .doc(id)
        .delete();
  }

  void calcTotal(String itemtitle, double itemtotal) {
    if (itemTotalPrice.containsKey(itemtitle)) {
      cartTotalPrice -= itemTotalPrice[itemtitle];
      itemTotalPrice[itemtitle] = itemtotal;
    } else {
      itemTotalPrice.addAll({itemtitle: itemtotal});
    }
    cartTotalPrice += itemtotal;
  }

  double getCartTotalPrice() {
    return cartTotalPrice;
  }

  void setFavoriteItem() {
    store
        .collection("users")
        .doc(CurrentUser.id)
        .collection("favorites")
        .doc(item["title"].toString())
        .set(item);
  }

  void deletFavoriteItem() {
    store
        .collection("users")
        .doc(CurrentUser.id)
        .collection("favorites")
        .doc(item["title"].toString())
        .delete();
  }

  void deleteFavoriteItem(String itemTitle) {
    store
        .collection("users")
        .doc(CurrentUser.id)
        .collection("favorites")
        .doc(itemTitle)
        .delete();
    custom.pref!.setBool("${CurrentUser.id}$itemTitle", false);
  }

  QuerySnapshot<Map<String, dynamic>>? docs;
  bool fireItemIsFavorit(Map<String, dynamic> favoriteitem) {
    store
        .collection("users")
        .doc("kHjhHeHS5TgXrZVXBR0lHPClZgF3")
        .collection("favorites")
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()["title"] == favoriteitem["title"]) {
          return true;
        }
      }
    });
    return false;
  }

  String categoryDytailsId = "";
  setCategoryDytailsId(String id) {
    categoryDytailsId = id;
    print(categoryDytailsId);
  }

  getCategoryDytailsId() {
    print(categoryDytailsId);
    return categoryDytailsId;
  }

}
