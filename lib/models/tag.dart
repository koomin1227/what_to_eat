class Tag {
  final String name;
  final String category;

  Tag({
    required this.name,
    required this.category,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'name': String name,
      'category': String category,
      } =>
          Tag(
            name: name,
            category: category,
          ),
      _ => throw const FormatException('Failed to load Tag.'),
    };
  }

  static List<Tag> listFromJson(Map<String, dynamic> json) {
    return [
      for (var element in json["tags"])
        Tag.fromJson(element)
    ];
  }

  static List<Tag> listFromJsonList(json) {
    return [
      for (var element in json)
        Tag.fromJson(element)
    ];
  }
}