import 'package:what_to_eat/models/model.dart';

import 'tag.dart';

class Tags extends Model<Tags>{
  List<Tag> tags;

  Tags({
    required this.tags,
  });

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(tags: parseTags(json["tags"]));
  }

  static List<Tag> parseTags(List<dynamic> json) {
    List<Tag> tags = [];
    for (var tag in json) {
      Tag tag2 = Tag(name: tag["name"], category: tag["category"]);
      tags.add(tag2);
    }
    return tags;
  }

  @override
  Tags fromJson(json) {
    return Tags.fromJson(json);
  }
}