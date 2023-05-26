import 'package:shop_app_/bloc/explor%20cubit/explore_states.dart';
import 'package:shop_app_/widgts/button.dart';

class TextState {
  String priceText;
  ExploreStatesEnum statesEnum;
  TextState({this.priceText = "", this.statesEnum = ExploreStatesEnum.initial});
  TextState copyWith({String? priceText, ExploreStatesEnum? statesEnum}) {
    return TextState(
        priceText: priceText ?? this.priceText,
        statesEnum: statesEnum ?? this.statesEnum);
  }
}
