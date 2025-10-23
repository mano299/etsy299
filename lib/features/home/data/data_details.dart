import 'dart:math';

import 'package:dio/dio.dart';
import 'package:etsy/features/home/data/model.dart';


class ProductData{
 static final Dio dio=Dio();
 static getData()async{
   final urls = [
     'https://dummyjson.com/products/category/mens-shirts',
     'https://fakestoreapi.com/products/category/electronics',
     'https://elwekala.onrender.com/product/Laptops',
   ];
   List<ProductModel> allProducts = [];

   for (var url in urls) {
     try {
       final response = await dio.get(url);

       dynamic data;

       if (response.data is Map<String, dynamic>) {
         data = response.data['products'] ??
             response.data['product'] ??
             response.data['data'] ??
             response.data['items'] ??
             response.data.values.firstWhere(
                   (v) => v is List,
               orElse: () => [],
             );
       } else if (response.data is List) {
         data = response.data;
       }

       if (data is List) {
         final List<ProductModel> products =
         data.map((e) => ProductModel.fromJson(e)).toList();
         allProducts.addAll(products);
       } else {
         print(" Unexpected data format from $url");
       }
     } catch (e) {
       print(" Error fetching data from $url: $e");
     }
   }

   print(' Total products fetched: ${allProducts.length}');
   return allProducts;
  }
}