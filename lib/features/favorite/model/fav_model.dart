class FavModel {
  final String image;
  final String category;
  final String description;
  final String price;
  final String brand;

  FavModel(
      {required this.image,
      required this.category,
      required this.description,
      required this.price,
      required this.brand});

  factory FavModel.fromjson(Map<String, dynamic> json) {
    return FavModel(
      image: json['image'] ?? json['thumbnail'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString())?.toStringAsFixed(2) ??
          '0.00',
      brand: json['brand'] ?? '',
    );
  }
}
