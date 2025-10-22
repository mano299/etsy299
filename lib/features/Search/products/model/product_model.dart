class ProductModel {
  final String image;
  final String id;
  final String status;
  final String name;
  final String category;
  final String description;
  final String company;
  final num price;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.image,
    required this.status,
    required this.name,
    required this.category,
    required this.description,
    required this.company,
    required this.price,
    required this.images,
  });

  factory ProductModel.fromjson(Map<String, dynamic> data) {
    return ProductModel(
      image: data['image'],
      category: data['category'],
      description: data['description'],
      company: data['company'],
      price: data['price'],
      images: List<String>.from(data['images']),
      name: data['name'],
      status: data['status'],
      id: data['_id'],
    );
  }
}
