class ModelProducts {
  final String title;
  final String decription;
  final String category;
  final String image;
  final String rating;
  final num price;

  ModelProducts({
    required this.title,
    required this.decription,
    required this.category,
    required this.image,
    required this.rating,
    required this.price,
  });
  factory ModelProducts.fromJson(Map<String, dynamic> data) {
    return ModelProducts(
      title: data['title'],
      decription: data['description'],
      category: data['category'],
      image: data['image'],
      rating: data['rating']["rate"].toString(),
      price: data['price'],
    );
  }
}
