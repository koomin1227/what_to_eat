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

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with TickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
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
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Title(restaurant: restaurant),
                      Divider(thickness: 0.5,),
                      DetailInfo(restaurant: restaurant),
                      ActionButtons(),
                      Divider(thickness: 0.5,),
                      Reviews(),
                    ],
                  ),
                ),
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

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Align(alignment: Alignment.topLeft, child: Text("리뷰",  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))],
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text("지도",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))
                ],
              )),
          VerticalDivider(
            indent: 8,
            endIndent: 8,
            thickness: 0.5,
          ),
          TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.ios_share_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  Text("공유",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))
                ],
              )),
        ],
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  const DetailInfo({
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
          TagList(restaurant: restaurant),
          SizedBox(
            height: 10,
          ),
          Info(
            kind: InfoKind.address,
            info: "경기 남양주시 화도읍 비룡로 145 1층",
          ),
          SizedBox(
            height: 10,
          ),
          Info(
            kind: InfoKind.phoneNumber,
            info: "031-511-9226",
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
    );
  }
}

class TagList extends StatelessWidget {
  const TagList({
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.5),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(16.0)),
              child: Text(
                "# ${tag.name}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  final String kind;
  final String info;

  const Info({
    super.key,
    required this.kind,
    required this.info,
  });

  getIcon(String kind) {
    if (kind == InfoKind.address) {
      return Icons.place;
    } else if (kind == InfoKind.phoneNumber) {
      return Icons.phone_iphone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          getIcon(kind),
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          info,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ],
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

class InfoKind {
  static String address = "address";
  static String phoneNumber = "phoneNumber";
}
