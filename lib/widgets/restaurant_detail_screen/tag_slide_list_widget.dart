import 'package:flutter/cupertino.dart';

import '../../models/restaurantDetail.dart';
import '../../models/tag.dart';
import '../common/tag_widget.dart';

class TagSlideList extends StatelessWidget {
  const TagSlideList({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (Tag tag in restaurant.tags)
            TagWidget(
              tag: tag,
              size: 20,
            ),
        ],
      ),
    );
  }
}
