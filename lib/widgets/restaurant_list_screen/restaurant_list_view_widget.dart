import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:what_to_eat/widgets/restaurant_list_screen/restaurant_card_widget.dart';

import '../../models/restaurant.dart';
import '../../controllers/restaurant_controller.dart';

class RestaurantListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RestaurantListViewState();
}

class RestaurantListViewState extends State<RestaurantListView> {
  final RestaurantController rc = Get.find<RestaurantController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => rc.pagingController.refresh()),
      child: PagedGridView(
        pagingController: rc.pagingController,
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
}
