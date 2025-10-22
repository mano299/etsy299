class ModelTShirts {
  final String title;
  final String description;
  final String category;
  final String thumbnail;
  final String brand;
  final List<String> images;
  final num price;
  final num discountPercentage;
  final num rating;
  final num stock;

  ModelTShirts({
    required this.brand,
    required this.title,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
  });

  factory ModelTShirts.fromJson(Map<String, dynamic> data) {
    return ModelTShirts(
      brand: data['brand'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      price: data['price'] ?? '',
      discountPercentage: data['discountPercentage'] ?? '',
      rating: data['rating'] ?? '',
      stock: data['stock'] ?? '',
    );
  }
}
