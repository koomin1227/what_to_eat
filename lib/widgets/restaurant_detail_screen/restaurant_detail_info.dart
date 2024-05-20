import 'package:flutter/cupertino.dart';
import 'package:what_to_eat/widgets/restaurant_detail_screen/tag_slide_list_widget.dart';

import '../../models/restaurantDetail.dart';
import '../../screens/restaurant_detail_screen.dart';
import 'info_widget.dart';

class RestaurantDetailInfo extends StatelessWidget {
  const RestaurantDetailInfo({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Column(
        children: [
          TagSlideList(restaurant: restaurant),
          SizedBox(
            height: 10,
          ),
          Info(
            icon: InfoKind.address,
            info: "경기 남양주시 화도읍 비룡로 145 1층",
          ),
          SizedBox(
            height: 10,
          ),
          Info(
            icon: InfoKind.phoneNumber,
            info: "031-511-9226",
          ),
        ],
      ),
    );
  }
}
