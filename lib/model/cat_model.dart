class CategoryModel {
  late String id;
  late String svgName;
  late String categoryName;

  CategoryModel({
    required this.id,
    this.svgName='',
    required this.categoryName,
});

  // receiving data from server
  CategoryModel.fromJson(map) {
    id = map['id'];
    svgName = map['svgName'];
    categoryName = map['categoryName'];

    // userNumber: map['userNumber'],
  }

  // sending data to our server
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'svgName': svgName,
      'categoryName': categoryName,

      // 'userNumber': userNumber
    };
  }
}
