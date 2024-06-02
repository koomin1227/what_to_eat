import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:what_to_eat/controllers/restaurant_controller.dart';

class RestaurantSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RestaurantController rc = Get.find<RestaurantController>();

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
            Theme.of(context).colorScheme.primary,
            Colors.white
          ])),
      child: SearchBar(
        trailing: [
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                rc.searchRestaurantByKeyword();
              },
              icon: Icon(Icons.search))
        ],
        onSubmitted: (value) {
          rc.searchRestaurantByKeyword();
        },
        onChanged: (value) {
          rc.updateSearchText(value);
        },
      ),
    );
  }
}
