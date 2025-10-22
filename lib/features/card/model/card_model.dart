class CardModel {
  final String category;
  final String name;
  final num price;
  final String image;
  final String company;
  final String id;
   num quantity;
  final num totalPrice;
  final num sales;

  CardModel({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.image,
    required this.company,
    required this.quantity,
    required this.sales,
    required this.totalPrice,
  });
  factory CardModel.fromdata(Map<String, dynamic> json) {
    return CardModel(
      category: json['category'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      company: json['company'],
      id: json['_id'],
      quantity: json['quantity'],
      sales: json['sales'],
      totalPrice: json['totalPrice'],
    );
  }
}