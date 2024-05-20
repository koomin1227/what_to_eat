import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/tag.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.tag,
    required this.size,
  });

  final double size;
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(16.0)),
      child: Text(
        "# ${tag.name}",
        style: TextStyle(color: Colors.white, fontSize: size),
      ),
    );
  }
}
