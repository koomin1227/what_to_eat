import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/restaurant_list_screen.dart';

class PlaceSelectButtons extends StatelessWidget {
  const PlaceSelectButtons({
    super.key,
    this.setPlace,
    this.searchOption,
  });

  final setPlace;
  final searchOption;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PlaceButton(
          buttonName: "전체",
          searchOption: searchOption,
          setPlace: setPlace,
        ),
        PlaceButton(
          buttonName: "건대",
          searchOption: searchOption,
          setPlace: setPlace,
        ),
        PlaceButton(
          buttonName: "홍대",
          searchOption: searchOption,
          setPlace: setPlace,
        ),
        PlaceButton(
          buttonName: "잠실",
          searchOption: searchOption,
          setPlace: setPlace,
        ),
        PlaceButton(
          buttonName: "강남",
          searchOption: searchOption,
          setPlace: setPlace,
        ),
        PlaceButton(
          buttonName: "신촌",
          searchOption: searchOption,
          setPlace: setPlace,
        ),
      ],
    );
  }
}

class PlaceButton extends StatelessWidget {
  const PlaceButton({
    super.key,
    required this.buttonName,
    required this.setPlace,
    required this.searchOption,
  });

  final Function setPlace;
  final SearchOption searchOption;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 50,
      child: TextButton(
        onPressed: () async {
          print(buttonName);
          setPlace(buttonName);
        },
        style: TextButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            backgroundColor: searchOption.selectedPlace == buttonName
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background),
        child: Text(buttonName,
            style: searchOption.selectedPlace == buttonName
                ? TextStyle(color: Colors.white)
                : TextStyle(color: Colors.black)),
      ),
    );
  }
}