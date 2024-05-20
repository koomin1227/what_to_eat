import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/restaurant_list_screen/place_select_buttons_widget.dart';
import '../widgets/restaurant_list_screen/restaurant_list_view_widget.dart';
import '../widgets/restaurant_list_screen/restaurant_search_bar_widget.dart';
import '../widgets/restaurant_list_screen/tag_selector_widget.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantListScreenState();
}

class RestaurantListScreenState extends State<RestaurantListScreen> {
  SearchOption searchOption =
      SearchOption(false, selectedPlace: "전체", searchText: "");

  Future<void> setPlace(String place) async {
    setState(() {
      searchOption.selectedPlace = place;
      searchOption.isSearch = false;
      searchOption.changeStatus();
    });
  }

  void setSearchOption() {
    setState(() {
      searchOption.isSearch = true;
      searchOption.selectedPlace = "전체";
      searchOption.changeStatus();
    });
  }

  void updateSearchKeyword(String value) {
    searchOption.searchText = value;
  }

  void updateSearchOption() {
    setState(() {
      searchOption.changeStatus();
    });
  }

  @override
  void initState() {
    setPlace("전체");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantSearchBar(
            setSearchOption: setSearchOption,
            updateSearchKeyword: updateSearchKeyword),
        SizedBox(width: 10, height: 10),
        PlaceSelectButtons(
          searchOption: searchOption,
          setPlace: setPlace,
        ),
        TagSelector(searchOption: searchOption, updateSearchOption: updateSearchOption,),
        Expanded(
          child: RestaurantListView(
            key: ValueKey(searchOption.getChange()),
            searchOption: searchOption,
          ),
        )
      ],
    );
  }
}

class SearchOption {
  bool isSearch;
  String? selectedPlace;
  String? searchText;
  List<String> selectedTags = [];
  bool change = true;

  SearchOption(this.isSearch, {this.selectedPlace, this.searchText});

  void changeStatus() {
    change = change ? false : true;
  }

  bool getChange() {
    return change;
  }
}
