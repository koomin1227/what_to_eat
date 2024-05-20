import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_to_eat/services/network_service.dart';
import 'package:what_to_eat/utils/data_extractor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../models/tag.dart';
import '../models/restaurant.dart';
import 'restaurant_datail_page.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantPageState();
}

class RestaurantPageState extends State<RestaurantPage> {
  SearchOption searchOption = SearchOption(false, selectedPlace: "전체", searchText: "");
  String selectedPlace = "전체";
  String searchText = "";
  List<Restaurant> restaurants = [];
  bool _expanded = false;

  List<String> tags = [];
  List<String> selectedTags = [];

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  Future<void> setPlace(String place) async {
    setState(() {
      searchOption.selectedPlace = place;
      searchOption.isSearch= false;
      searchOption.changeStatus();
    });
  }

  parseTags() async {
    var response = await NetworkService.getTags();
    List<Tag> tagList = Tag.listFromJson(DataExtractor.extractData(response));
    tags = tagList.map((toElement) => toElement.name).toList();
    setState(() {

    });
  }

  @override
  void initState()  {
    setPlace("전체");
    parseTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Theme.of(context).colorScheme.primary, Colors.white]
              )
            ),
          child: SearchBar(
            trailing: [
              IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      searchOption.isSearch = true;
                      searchOption.selectedPlace = "전체";
                      searchOption.changeStatus();
                    });
                  },
                  icon: Icon(Icons.search))
            ],
            onSubmitted: (value) {
              setState(() {
                searchOption.isSearch = true;
                searchOption.searchText = value;
                searchOption.selectedPlace = "전체";
                searchOption.changeStatus();
              });
            },
            onChanged: (value) {
              searchOption.searchText = value;
            },
          ),
        ),
        SizedBox(width: 10, height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PlaceButton(buttonName: "전체", searchOption: searchOption, setPlace: setPlace,),
            PlaceButton(buttonName: "건대", searchOption: searchOption, setPlace: setPlace,),
            PlaceButton(buttonName: "홍대", searchOption: searchOption, setPlace: setPlace,),
            PlaceButton(buttonName: "잠실", searchOption: searchOption, setPlace: setPlace,),
            PlaceButton(buttonName: "강남", searchOption: searchOption, setPlace: setPlace,),
            PlaceButton(buttonName: "신촌", searchOption: searchOption, setPlace: setPlace,),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_expanded)
                Column(
                  children: [
                    Align(alignment: Alignment.topLeft, child: Text("# 태그", style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold)),),
                    SizedBox(height: 10,),
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
                      for(String tag in tags)
                        SizedBox(
                          height : 25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: searchOption.selectedTags.contains(tag)? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                                side: BorderSide(color: searchOption.selectedTags.contains(tag)? Theme.of(context).colorScheme.primary : Colors.grey),
                            ),
                            onPressed: () {
                              if (searchOption.selectedTags.contains(tag)) {
                                searchOption.selectedTags.remove(tag);
                              } else {
                                searchOption.selectedTags.add(tag);
                              }
                              setState(() {});
                            },
                            child: Text("# ${tag}",
                              style: TextStyle(color: searchOption.selectedTags.contains(tag)? Theme.of(context).colorScheme.background : Colors.black),
                            ),
                          ),
                        ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 35,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey)),
                                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                                    backgroundColor: Theme.of(context).colorScheme.background
                                ),
                                onPressed: () {
                                  setState(() {
                                    searchOption.selectedTags.clear();
                                  });
                                },
                                child: Text(
                                  "초기화",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                )
                            ),
                          ),
                          // SizedBox(width: 10,),
                          SizedBox(
                            width: 160,
                            height: 35,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                                backgroundColor: Theme.of(context).colorScheme.primary
                              ),
                                onPressed: () {
                                  setState(() {
                                    searchOption.isSearch = false;
                                    searchOption.changeStatus();
                                  });
                                  _toggleExpand();
                                },
                                child: Text(
                                  "결과보기",
                                  style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold,fontSize: 15),
                                )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
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
                  icon: _expanded ? Icon(Icons.arrow_drop_up, color: Theme.of(context).colorScheme.primary,) : Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary,),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              child: RestaurantListView(key: ValueKey(searchOption.getChange()), searchOption: searchOption,)
          ),
        )
      ],
    );
  }
}

class RestaurantListView extends StatefulWidget {
  const RestaurantListView({super.key, required this.searchOption});
  // final String selectedPlace;
  final SearchOption searchOption;

  @override
  State<StatefulWidget> createState() => RestaurantListViewState();
}

class RestaurantListViewState extends State<RestaurantListView>{
  static const _pageSize = 10;
  final PagingController<int, Restaurant> _pagingController = PagingController(firstPageKey: 1);


  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    Future.sync(() => _pagingController.refresh());
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newItems;
      if (widget.searchOption.isSearch) {
        newItems = Restaurant.listFromJson(DataExtractor.extractData(
            await NetworkService.getRestaurantsBySearch(widget.searchOption.searchText!, pageKey)));
      } else {
        newItems = Restaurant.listFromJson(DataExtractor.extractData(
            await NetworkService.getRestaurants(widget.searchOption.selectedPlace!, widget.searchOption.selectedTags, pageKey)));
      }

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedGridView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: RestaurantCard(context: context, restaurant: item as Restaurant),
            )
          ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 11.4/12,
        ),
      ),
    );
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.context,
    required this.restaurant,
  });

  final BuildContext context;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RestaurantDetailPage()));
      },
      child: Container(
          width: 190,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          margin: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Column(
            children: [
              Image.network(
                restaurant.thumbnail,
                width: 180,
                height: 80,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Text(
                    restaurant.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 7,),
              Container(
                // height: 50,
                constraints: BoxConstraints(maxHeight: 55),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ClipRect(
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for(Tag tag in restaurant.tags)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.5),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                border: Border.all(color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(16.0)
                            ),
                            child: Text("# ${tag.name}",
                              style: TextStyle(color: Colors. white),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class PlaceButton extends StatelessWidget {
  const PlaceButton({
    super.key,
    required this.buttonName,
    required this.setPlace,
    required this.searchOption,
  });
  final Function setPlace;
  final SearchOption searchOption;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 50,
      child: TextButton(
        onPressed: () async {
          print(buttonName);
          setPlace(buttonName);
        },
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            backgroundColor: searchOption.selectedPlace == buttonName
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background
        ),
        child: Text(buttonName,
            style: searchOption.selectedPlace == buttonName
                ? TextStyle(color: Colors.white)
                : TextStyle(color: Colors.black)),
      ),
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
    change = change? false:true;
  }

  bool getChange() {
    return change;
  }
}