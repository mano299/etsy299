import 'package:etsy/features/Search/Electronics/data/model_products.dart';
import 'package:flutter/material.dart';

class Electronics extends StatelessWidget {
  const Electronics({super.key, required this.model});
  final ModelProducts model;

  @override
  Widget build(BuildContext context) {
    return  Card(
        color: Color(0xFF312b35),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(model.image , height: 150,),
              ),
              Text(
                model.title,
                maxLines: 3,overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Category: ${model.category}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            
              Row(
                children: [
                  Icon(Icons.monetization_on_outlined, color: Colors.white),
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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