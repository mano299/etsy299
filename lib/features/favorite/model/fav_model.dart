class FavModel{
  final String image;
  final String category;
  final String description;
  final String price;
  final String brand;


  FavModel({
    required this.image,
    required this.category,
    required this.description,
    required this.price,
    required this.brand
  });

  factory FavModel.fromjson(Map<String,dynamic>json)
  {
    return FavModel(
      image: json ['image']?? json['thumbnail'] ??'',
      category:json ['category'],
      description:json ['description'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] ?? 0.0).toDouble(),
      brand:json['brand'] ??'',
    );
  }
}
