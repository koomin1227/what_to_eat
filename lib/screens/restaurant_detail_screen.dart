import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_to_eat/services/restaurant_service.dart';

import '../models/restaurantDetail.dart';
import '../widgets/restaurant_detail_screen/action_buttons_widget.dart';
import '../widgets/restaurant_detail_screen/restaurant_detail_info.dart';
import '../widgets/restaurant_detail_screen/restaurant_header_widget.dart';
import '../widgets/restaurant_detail_screen/restaurant_main_image_widget.dart';
import '../widgets/restaurant_detail_screen/reviews_widget.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with TickerProviderStateMixin {
  RestaurantService restaurantService = RestaurantService();
  late Future<RestaurantDetail> restaurantDetail;

  Future<RestaurantDetail> fetchData() async {
    try {
      RestaurantDetail restaurantDetail =
          await restaurantService.getRestaurant(widget.restaurantId);
      return restaurantDetail;
    } on Exception catch (e) {
      throw Exception('No data found for this restaurant');
    }
  }

  @override
  void initState() {
    super.initState();
    restaurantDetail = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<RestaurantDetail>(
        future: restaurantDetail,
        builder:
            (BuildContext context, AsyncSnapshot<RestaurantDetail> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            var restaurant = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      var top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        title: top <= 120
                            ? Text(
                                restaurant.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : null,
                        background: RestaurantMainImage(restaurant: restaurant),
                        collapseMode: CollapseMode.parallax,
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // RestaurantMainImage(restaurant: restaurant),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            RestaurantHeader(restaurant: restaurant),
                            Divider(thickness: 0.5),
                            RestaurantDetailInfo(restaurant: restaurant),
                            ActionButtons(),
                            Divider(thickness: 0.5),
                            Reviews(
                              reviews: restaurant.reviews,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Text('No data');
          }
        },
      ),
    );
  }
}

class InfoKind {
  static IconData address = Icons.place;
  static IconData phoneNumber = Icons.phone_iphone;
}
