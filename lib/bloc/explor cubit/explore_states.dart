import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum ExploreStatesEnum { search, initial, loading }

// ignore: must_be_immutable
class ExploreStates extends Equatable {
  List<Map<String, dynamic>> items = List.of([]);
  ExploreStatesEnum exploreStatesEnum;
  String searchVal;
  ExploreStates(
      {required this.items,
      this.exploreStatesEnum = ExploreStatesEnum.initial,
      this.searchVal = ""});

  @override
  List<Object?> get props => [exploreStatesEnum, items, searchVal];

  ExploreStates copyWith(
      {ExploreStatesEnum? exploreStatesEnum,
      List<Map<String, dynamic>>? items,
      String? searchVal}) {
    return ExploreStates(
        exploreStatesEnum: exploreStatesEnum ?? this.exploreStatesEnum,
        items: items ?? this.items,
        searchVal: searchVal ?? this.searchVal);
  }
}
