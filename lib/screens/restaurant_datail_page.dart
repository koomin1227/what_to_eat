import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:what_to_eat/services/network_service.dart';
import 'package:what_to_eat/utils/data_extractor.dart';

import '../models/restaurantDetail.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future<RestaurantDetail> restaurantDetail;

  Future<RestaurantDetail> fetchData() async {
    Response res = await NetworkService.getRestaurantDetail(
        widget.restaurantId);
    if (res.statusCode == 404) {
      throw Exception('No data found for this restaurant');
    }
    RestaurantDetail restaurantDetail = RestaurantDetail.fromJson(
        DataExtractor.extractData(res));
    return restaurantDetail;
  }

  @override
  void initState() {
    super.initState();
    restaurantDetail = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<RestaurantDetail>(
        future: restaurantDetail,
        builder: (BuildContext context,
            AsyncSnapshot<RestaurantDetail> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            var restaurant = snapshot.data!;
            return Column(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double width = constraints.maxWidth *
                        0.8; // Image width is 80% of the available width
                    double aspectRatio = 345 / 222; // Original aspect ratio
                    return AspectRatio(
                      aspectRatio: aspectRatio,
                      child: Image.network(
                        restaurant.thumbnail,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
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
                          Rating(),
                        ],
                      ),
                    ],
                  ),
                ),

                Text('Name: ${restaurant.name}'),
                Text('ID: ${restaurant.restaurantId}'),
                Text('Tags: ${restaurant.tags.join(', ')}'),
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

class Rating extends StatelessWidget {
  const Rating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow.shade600,),
        Text(
          "4.9",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}