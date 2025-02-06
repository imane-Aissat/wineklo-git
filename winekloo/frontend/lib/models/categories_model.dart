class Categories {
  final int? categoryID;
  final String? categoryName;

  Categories({
    this.categoryID,
    this.categoryName,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      categoryID: json['CategoryID'],
      categoryName: json['CategoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CategoryID': categoryID,
      'CategoryName': categoryName,
    };
  }
}