import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_to_eat/services/network_service.dart';
import 'package:what_to_eat/utils/data_extractor.dart';

import '../models/tag.dart';
import '../models/restaurant.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantPageState();
}

class RestaurantPageState extends State<RestaurantPage> {
  String selectedPlace = "전체";
  String searchText = "";
  List<Restaurant> restaurants = [];

  Future<void> setPlace(String place) async {
    var result = Restaurant.listFromJson(DataExtractor.extractData(await NetworkService.getRestaurants(place)));
    setState(() {
      selectedPlace = place;
      restaurants = result;
    });
  }

  @override
  void initState() {
    setPlace("전체");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SearchBar(
          trailing: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.search))
          ],
          onSubmitted: (value) {
            setState(() {
              searchText = value;
            });
          },
          onChanged: (value) {
            searchText = value;
          },
        ),
        SizedBox(width: 10, height: 10),
        Text(searchText),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlaceButton(buttonName: "전체", selectedPlace: selectedPlace, setPlace: setPlace,),
            PlaceButton(buttonName: "건대", selectedPlace: selectedPlace, setPlace: setPlace,),
            PlaceButton(buttonName: "홍대", selectedPlace: selectedPlace, setPlace: setPlace,),
            PlaceButton(buttonName: "잠실", selectedPlace: selectedPlace, setPlace: setPlace,),
            PlaceButton(buttonName: "강남", selectedPlace: selectedPlace, setPlace: setPlace,),
            PlaceButton(buttonName: "신촌", selectedPlace: selectedPlace, setPlace: setPlace,),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: restaurants.length ~/ 2,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RestaurantCard(context: context, restaurant: restaurants[index * 2]),
                    RestaurantCard(context: context, restaurant: restaurants[index * 2 + 1]),
                  ],
                );
              }),
        )
      ],
    );
  }
}

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
    return Container(
        width: 190,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: Column(
          children: [
            Image.network(
              restaurant.thumbnail,
              width: 180,
              height: 70,
              fit: BoxFit.cover,
            ),
            Text(
              restaurant.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black),
              textAlign: TextAlign.left,
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 7,),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              children: [
                for(Tag tag in restaurant.tags)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: Text("# ${tag.name}",
                      style: TextStyle(color: Colors. white),
                    ),
                  )
              ],
            )
          ],
        ));
  }
}

class PlaceButton extends StatelessWidget {
  const PlaceButton({
    super.key,
    required this.buttonName,
    required this.setPlace,
    required this.selectedPlace,
  });
  final Function setPlace;
  final String selectedPlace;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        print(buttonName);
        setPlace(buttonName);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              selectedPlace == buttonName
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background)),
      child: Text(buttonName,
          style: selectedPlace == buttonName
              ? TextStyle(color: Colors.white)
              : TextStyle(color: Colors.black)),
    );
  }
}