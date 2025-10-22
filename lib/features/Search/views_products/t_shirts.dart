import 'package:etsy/features/Search/T_shirts/data/model_t_shirts.dart';
import 'package:flutter/material.dart';

class TShirts extends StatelessWidget {
  const TShirts({super.key, required this.model});
  final ModelTShirts model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF312b35),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(model.thumbnail, fit: BoxFit.fill),
            Text(
              model.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.monetization_on_outlined, color: Colors.white),
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
