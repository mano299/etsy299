import 'package:etsy/features/Search/products/model/product_model.dart';
import 'package:flutter/material.dart';

class Laptops extends StatelessWidget {
  const Laptops({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF312b35),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 9,
          children: [
            Image.network(
              model.image,
              height: 150,
              fit: BoxFit.fill,
            ),
            Text(
              model.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Icon(Icons.monetization_on_outlined, color: Colors.white),
                Text(
                  model.price.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}