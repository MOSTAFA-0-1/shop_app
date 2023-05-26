
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/bloc/explor%20cubit/explore_states.dart';
import 'package:shop_app_/widgts/Price_Text/price_text_state.dart';

class PriceTextCubit extends Cubit<TextState> {
  PriceTextCubit() : super(TextState());
 
 void getPriceText(String price){
    emit(state.copyWith(priceText: price,statesEnum: ExploreStatesEnum.loading));
   }

}