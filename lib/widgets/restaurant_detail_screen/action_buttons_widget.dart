import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ],
              )),
        ],
      ),
    );
  }
}
