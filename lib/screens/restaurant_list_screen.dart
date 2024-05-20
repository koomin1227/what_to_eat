import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_to_eat/services/network_service.dart';
import 'package:what_to_eat/utils/data_extractor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/tag.dart';
import '../models/restaurant.dart';
import '../widgets/restaurant_list_screen/place_select_buttons_widget.dart';
import '../widgets/restaurant_list_screen/restaurant_card_widget.dart';
import '../widgets/restaurant_list_screen/restaurant_list_view_widget.dart';
import '../widgets/restaurant_list_screen/restaurant_search_bar_widget.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantListScreenState();
}

class RestaurantListScreenState extends State<RestaurantListScreen> {
  SearchOption searchOption =
      SearchOption(false, selectedPlace: "전체", searchText: "");
  bool _expanded = false;

  List<String> tags = [];

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  Future<void> setPlace(String place) async {
    setState(() {
      searchOption.selectedPlace = place;
      searchOption.isSearch = false;
      searchOption.changeStatus();
    });
  }

  parseTags() async {
    var response = await NetworkService.getTags();
    List<Tag> tagList = Tag.listFromJson(DataExtractor.extractData(response));
    tags = tagList.map((toElement) => toElement.name).toList();
    setState(() {});
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

  @override
  void initState() {
    setPlace("전체");
    parseTags();
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
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_expanded)
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("# 태그",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                constraints: BoxConstraints(maxHeight: _expanded ? 600 : 25),
                child: ClipRect(
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (String tag in tags)
                        SizedBox(
                          height: 25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: searchOption.selectedTags
                                      .contains(tag)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 4),
                              side: BorderSide(
                                  color: searchOption.selectedTags.contains(tag)
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey),
                            ),
                            onPressed: () {
                              if (searchOption.selectedTags.contains(tag)) {
                                searchOption.selectedTags.remove(tag);
                              } else {
                                searchOption.selectedTags.add(tag);
                              }
                              setState(() {});
                            },
                            child: Text(
                              "# ${tag}",
                              style: TextStyle(
                                  color: searchOption.selectedTags.contains(tag)
                                      ? Theme.of(context).colorScheme.background
                                      : Colors.black),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 35,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: Colors.grey)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 4),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background),
                                onPressed: () {
                                  setState(() {
                                    searchOption.selectedTags.clear();
                                  });
                                },
                                child: Text(
                                  "초기화",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                          ),
                          // SizedBox(width: 10,),
                          SizedBox(
                            width: 160,
                            height: 35,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 4),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary),
                                onPressed: () {
                                  setState(() {
                                    searchOption.isSearch = false;
                                    searchOption.changeStatus();
                                  });
                                  _toggleExpand();
                                },
                                child: Text(
                                  "결과보기",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              Divider(
                color: Theme.of(context).colorScheme.primary,
                height: 1,
                thickness: 2.5,
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(
                height: 20,
                child: IconButton(
                  padding: EdgeInsets.zero, // 패딩 설정
                  constraints: BoxConstraints(),
                  onPressed: _toggleExpand,
                  icon: _expanded
                      ? Icon(
                          Icons.arrow_drop_up,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ),
            ],
          ),
        ),
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
