import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:what_to_eat/services/restaurant_service.dart';
import 'package:what_to_eat/widgets/restaurant_list_screen/restaurant_card_widget.dart';

import '../../models/restaurant.dart';
import '../../screens/restaurant_list_screen.dart';

class RestaurantListView extends StatefulWidget {
  const RestaurantListView({super.key, required this.searchOption});

  final SearchOption searchOption;

  @override
  State<StatefulWidget> createState() => RestaurantListViewState();
}

class RestaurantListViewState extends State<RestaurantListView> {
  static const _pageSize = 10;
  final RestaurantService restaurantService = RestaurantService();
  final PagingController<int, Restaurant> _pagingController =
      PagingController(firstPageKey: 1);

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
        newItems = await restaurantService.getRestaurantListByKeyword(
            widget.searchOption.searchText!, pageKey);
      } else {
        newItems = await restaurantService.getRestaurantListByTag(
            widget.searchOption.selectedPlace!,
            widget.searchOption.selectedTags,
            pageKey);
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  child: RestaurantCard(
                      context: context, restaurant: item as Restaurant),
                )),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 11.4 / 12,
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
