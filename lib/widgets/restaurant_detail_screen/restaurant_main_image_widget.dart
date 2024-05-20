import 'package:flutter/cupertino.dart';

import '../../models/restaurantDetail.dart';

class RestaurantMainImage extends StatelessWidget {
  const RestaurantMainImage({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth *
            0.8; // Image width is 80% of the available width
        double aspectRatio = 345 / 250; // Original aspect ratio
        return AspectRatio(
          aspectRatio: aspectRatio,
          child: Image.network(
            restaurant.thumbnail,
            width: width,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
