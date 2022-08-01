class SliderModel {
  late String image;

  SliderModel(
    this.image,
  );
  SliderModel.fromMap(Map map) {
    image = map['image'];
  }
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }
}
