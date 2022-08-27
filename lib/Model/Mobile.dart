class MobileModel {
  String image, name;
  double price, rating;
  bool isOffered, favourite;
  int review;

  MobileModel(
      {required this.image,
      required this.name,
      required this.rating,
      required this.price,
      required this.favourite,
      required this.isOffered,
      required this.review});
}
