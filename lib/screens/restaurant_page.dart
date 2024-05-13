import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantPageState();
}

class RestaurantPageState extends State<RestaurantPage> {
  var selectedPlace = "전체";
  List<Restaurant> restaurants = Restaurant.getRes("전체");

  String searchText = "";

  void setPlace(String place) {
    setState(() {
      selectedPlace = place;
      restaurants = Restaurant.getRes(place);
    });
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
              restaurant.image,
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
                for(String tag in restaurant.tags)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: Text("#$tag",
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

class Restaurant {
  String name;
  List<String> tags;
  String image;

  Restaurant(this.name, this.tags, this.image);

  static List<Restaurant> getRes(String place) {
    List<Restaurant> restaurants = [];
    restaurants.add(Restaurant("버거킹 $place점", tag1, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190827_194%2F15668335666964ELt3_JPEG%2FqoQt0sFHslMHiBwIRZPmnxuX.jpg"));
    restaurants.add(Restaurant("롯데리아 $place점", tag3, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240207_300%2F1707268553325GfUKX_PNG%2F%25BA%25F1%25BA%25F6.png"));
    restaurants.add(Restaurant("할매 순대국 $place점", tag2, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231204_29%2F1701654815177xPjXe_JPEG%2F%25BF%25C0%25B8%25AE%25BF%25AA%25C1%25A1%252823.12.4%2529.jpg"));
    restaurants.add(Restaurant("도미노 피자 $place점", tag4, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190805_211%2F1564973506757fTup4_JPEG%2FU6XIrbRh1-XfDdLB-iTFckTt.jpg"));
    restaurants.add(Restaurant("딸부자네 불백 $place점", tag1, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180826_93%2F1535267045454i7S1I_JPEG%2FrpaqqDGI0-bgKXtS5u4mcPL9.jpg"));
    restaurants.add(Restaurant("깍둑 $place점", tag3, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221208_92%2F1670437774137P9rC6_JPEG%2F20181102_154139.jpg"));
    restaurants.add(Restaurant("소담 $place점", tag4, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200526_87%2F1590497075280Of5O0_JPEG%2FEyJMjy6Nl96Husl4M1Z01lhC.jpg"));
    restaurants.add(Restaurant("생활맥주 $place점", tag2, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161010_79%2F1476089690746kf1Si_JPEG%2F176954504120229_0.jpeg"));
    restaurants.add(Restaurant("서브웨이 $place점", tag1, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200103_82%2F1578043664049aVIC6_JPEG%2FoSo1QnUl87teoesK_lCcVLN0.jpg"));
    restaurants.add(Restaurant("이태리 부대찌개 $place점", tag4, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200606_108%2F1591433331292166Cq_JPEG%2FAsp8RdBERtPx2fpfsHtlIE6V.jpg"));
    restaurants.add(Restaurant("이태리 부대찌개 $place점", tag4, "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200606_108%2F1591433331292166Cq_JPEG%2FAsp8RdBERtPx2fpfsHtlIE6V.jpg"));
    restaurants.shuffle();
    return restaurants;
  }
}

List<String> tag1 = ["맛있는", "분위기 좋은", "가족 식사"];
List<String> tag2 = ["데이트", "간단한", "가족 식사"];
List<String> tag3 = ["고급스러운", "신선한", "조용한", "분위기 좋은"];
List<String> tag4 = ["깔끔한", "친절한", "저렴한"];