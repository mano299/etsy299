class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double parsePrice(dynamic value) {
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    ;
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['name'] ?? '',
      description: json['description'] ?? json['desc'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? json['thumbnail'] ?? json['photo'] ?? '',
      images: (json['images'] != null)
          ? (json['images'] is List
              ? List<String>.from(json['images'])
              : [json['images'].toString()])
          : [json['image']?.toString() ?? json['thumbnail']?.toString() ?? ''],
    );
  }
}
