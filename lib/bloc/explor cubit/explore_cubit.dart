
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/bloc/explor%20cubit/explore_states.dart';
import 'package:shop_app_/custom.dart';

class ExploreCubit extends Cubit<ExploreStates> {
  ExploreCubit() : super(ExploreStates(items: []));

 void getSearchItems(
      List<String> categoryNames, String searchVal) async {
 if (searchVal == "") {
      emit(state.copyWith(exploreStatesEnum: ExploreStatesEnum.initial,items: [],searchVal: "")); 
    } 
       else  {
        state.items.clear();
    for (var i = 0; i < categoryNames.length; i++) {
      await custom.store
          .collection("categorys")
          .doc(categoryNames[i])
          .collection("products")
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (element
              .data()["title"]
              .toString()
              .toLowerCase()
              .contains(searchVal.toLowerCase())) {
            // print(element.data()["title"]);
            state.items.add(element.data());
          } else {
            continue;
          }
          //  print(element.data());
        }
      });
    }
    if(searchVal != "") {
      emit(state.copyWith(items: state.items,exploreStatesEnum: ExploreStatesEnum.search,searchVal: searchVal));
    }
        }
       
  }
}
