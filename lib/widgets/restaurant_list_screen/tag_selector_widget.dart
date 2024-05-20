import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/tag.dart';
import '../../screens/restaurant_list_screen.dart';
import '../../services/network_service.dart';
import '../../utils/data_extractor.dart';

class TagSelector extends StatefulWidget {
  final SearchOption searchOption;
  final updateSearchOption;

  const TagSelector(
      {super.key, required this.searchOption, this.updateSearchOption});

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  List<String> tags = [];
  bool _expanded = false;

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  parseTags() async {
    var response = await NetworkService.getTags();
    List<Tag> tagList = Tag.listFromJson(DataExtractor.extractData(response));
    tags = tagList.map((toElement) => toElement.name).toList();
    setState(() {});
  }

  void search() {
    setState(() {
      widget.searchOption.isSearch = false;
      widget.updateSearchOption();
    });

    _toggleExpand();
  }

  @override
  void initState() {
    parseTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_expanded)
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("# 태그",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                constraints: BoxConstraints(maxHeight: _expanded ? 600 : 25),
                child: ClipRect(
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (String tag in tags)
                        buildTagSelectButton(tag, context),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TagActionButton(
                            name: "초기화",
                            onPressedAction: () {
                              setState(() {
                                widget.searchOption.selectedTags.clear();
                              });
                            },
                          ),
                          TagActionButton(
                            name: "결과보기",
                            onPressedAction: search,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              Divider(
                color: Theme.of(context).colorScheme.primary,
                height: 1,
                thickness: 2.5,
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(
                height: 20,
                child: IconButton(
                  padding: EdgeInsets.zero, // 패딩 설정
                  constraints: BoxConstraints(),
                  onPressed: _toggleExpand,
                  icon: _expanded
                      ? Icon(
                          Icons.arrow_drop_up,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox buildTagSelectButton(String tag, BuildContext context) {
    return SizedBox(
      height: 25,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: widget.searchOption.selectedTags.contains(tag)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          side: BorderSide(
              color: widget.searchOption.selectedTags.contains(tag)
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey),
        ),
        onPressed: () {
          if (widget.searchOption.selectedTags.contains(tag)) {
            widget.searchOption.selectedTags.remove(tag);
          } else {
            widget.searchOption.selectedTags.add(tag);
          }
          setState(() {});
        },
        child: Text(
          "# ${tag}",
          style: TextStyle(
              color: widget.searchOption.selectedTags.contains(tag)
                  ? Theme.of(context).colorScheme.background
                  : Colors.black),
        ),
      ),
    );
  }
}

class TagActionButton extends StatelessWidget {
  final String name;
  final onPressedAction;

  const TagActionButton({super.key, required this.name, this.onPressedAction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 35,
      child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              backgroundColor: Theme.of(context).colorScheme.primary),
          onPressed: () {
            onPressedAction();
          },
          child: Text(
            name,
            style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          )),
    );
  }
}
