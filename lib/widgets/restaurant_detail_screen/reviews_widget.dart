import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  final List<String> reviews;

  const Reviews({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "리뷰",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        if (reviews.isNotEmpty)
          for (String review in reviews) Review(contents: review)
        else
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "리뷰가 없습니다.",
              style: TextStyle(color: Colors.grey),
            ),
          )
      ],
    );
  }
}

class Review extends StatelessWidget {
  final String contents;

  const Review({
    super.key,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "rry****",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          Align(alignment: Alignment.topLeft, child: Text(contents)),
          Divider(),
        ],
      ),
    );
  }
}
