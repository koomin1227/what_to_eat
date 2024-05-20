import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import '../../models/tag.dart';
import '../../screens/restaurant_detail_screen.dart';
import '../common/tag_widget.dart';

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(
                  restaurantId: restaurant.restaurantId,
                )));
      },
      child: Container(
          width: 190,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          margin: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0)),
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
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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
              SizedBox(
                height: 7,
              ),
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
                        for (Tag tag in restaurant.tags)
                          TagWidget(tag: tag, size: 15)
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