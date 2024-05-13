import 'package:what_to_eat/models/model.dart';

import 'tag.dart';

class Tags extends Model<Tags>{
  List<Tag>? tags;

  Tags({
    this.tags,
  });

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(tags: parseTags(json["tags"]));
  }

  static List<Tag> parseTags(List<dynamic> tags) {
    List<Tag> tags2 = [];
    for (var tag in tags) {
      Tag tag2 = Tag(name: tag["name"], category: tag["category"]);
      tags2.add(tag2);
    }
    return tags2;
  }

  @override
  Tags fromJson(json) {
    return Tags.fromJson(json);
  }
}