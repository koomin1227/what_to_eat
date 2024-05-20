import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:what_to_eat/services/network_service.dart';
import 'package:what_to_eat/utils/data_extractor.dart';

import '../models/restaurantDetail.dart';
import '../models/tag.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> with TickerProviderStateMixin {
  late Future<RestaurantDetail> restaurantDetail;

  Future<RestaurantDetail> fetchData() async {
    Response res =
        await NetworkService.getRestaurantDetail(widget.restaurantId);
    if (res.statusCode == 404) {
      throw Exception('No data found for this restaurant');
    }
    RestaurantDetail restaurantDetail =
        RestaurantDetail.fromJson(DataExtractor.extractData(res));
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
        builder:
            (BuildContext context, AsyncSnapshot<RestaurantDetail> snapshot) {
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
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Rating(),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '리뷰 157개',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Divider(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (Tag tag in restaurant.tags)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 0.5),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Text(
                                  "# ${tag.name}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                          ],
                        ),
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
  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(8.0),
        color: Colors.amber,
        child: Text(
          item,
          style: TextStyle(fontSize: 16),
        ),
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
        Icon(
          Icons.star,
          color: Colors.yellow.shade600,
        ),
        Text(
          "4.9",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
