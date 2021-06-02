class Category {
  String category;
  String key;

  Category({
    this.category,
    this.key,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json["category"], 
      key: json["key"], 
    );
  }

  Map<String, dynamic> toJson() {
    return {"category": category, "key": key,};
  }

  @override
  String toString() {
    return 'Category{category: $category, key: $key,}';
  }
}
