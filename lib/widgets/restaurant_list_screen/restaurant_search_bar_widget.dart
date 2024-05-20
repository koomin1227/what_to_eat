import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantSearchBar extends StatelessWidget {
  const RestaurantSearchBar({
    super.key,
    this.setSearchOption,
    this.updateSearchKeyword,
  });

  final setSearchOption;
  final updateSearchKeyword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Theme.of(context).colorScheme.primary,
                Colors.white
              ])),
      child: SearchBar(
        trailing: [
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                setSearchOption();
              },
              icon: Icon(Icons.search))
        ],
        onSubmitted: (value) {
          setSearchOption();
        },
        onChanged: (value) {
          updateSearchKeyword(value);
        },
      ),
    );
  }
}