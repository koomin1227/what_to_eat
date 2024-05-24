import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/restaurant_controller.dart';

class PlaceSelector extends StatelessWidget {
  const PlaceSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PlaceButton(
          buttonName: "전체",
        ),
        PlaceButton(
          buttonName: "건대",
        ),
        PlaceButton(
          buttonName: "홍대",
        ),
        PlaceButton(
          buttonName: "잠실",
        ),
        PlaceButton(
          buttonName: "강남",
        ),
        PlaceButton(
          buttonName: "신촌",
        ),
      ],
    );
  }
}

class PlaceButton extends StatelessWidget {
  const PlaceButton({
    super.key,
    required this.buttonName,
  });

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    final RestaurantController rc = Get.find<RestaurantController>();

    return SizedBox(
      height: 25,
      width: 50,
      child: Obx(() => TextButton(
            onPressed: () async {
              print(buttonName);
              rc.setPlace(buttonName);
            },
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                backgroundColor: rc.place.value == buttonName
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background),
            child: Text(buttonName,
                style: rc.place.value == buttonName
                    ? TextStyle(color: Colors.white)
                    : TextStyle(color: Colors.black)),
          )),
    );
  }
}
