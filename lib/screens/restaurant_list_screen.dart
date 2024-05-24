import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/restaurant_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    final RestaurantController c = Get.put(RestaurantController());
    return Column(
      children: [
        RestaurantSearchBar(),
        SizedBox(width: 10, height: 10),
        PlaceSelector(),
        TagSelector(),
        Expanded(
          child: RestaurantListView(),
        )
      ],
    );
  }
}
