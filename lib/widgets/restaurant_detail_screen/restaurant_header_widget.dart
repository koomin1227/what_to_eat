import 'package:flutter/cupertino.dart';
import 'package:what_to_eat/widgets/restaurant_detail_screen/rating_widget.dart';

import '../../models/restaurantDetail.dart';

class RestaurantHeader extends StatelessWidget {
  const RestaurantHeader({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            restaurant.name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Rating(rating: 4.9),
            SizedBox(
              width: 10,
            ),
            Text(
              '리뷰 157개',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
