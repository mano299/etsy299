import 'package:dio/dio.dart';
import 'package:etsy/features/Search/Electronics/data/model_products.dart';

class DataProducts {
  static Future<List<ModelProducts>> getDataProducts() async {
    Dio dio = Dio();
    var repo = await dio.get(
      "https://fakestoreapi.com/products/category/electronics",
    );
    List data = repo.data;
    List<ModelProducts> listProducts = data
        .map((e) => ModelProducts.fromJson(e))
        .toList();
    print(listProducts[0].image);
    print(listProducts[0].image);

    return listProducts;
  }
}
