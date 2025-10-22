import 'package:dio/dio.dart';
import 'package:etsy/features/Search/products/model/product_model.dart';

class ProductData {
  static Future<List<ProductModel>> getData() async {
    Dio dio = Dio();
    var repo = await dio.get("https://elwekala.onrender.com/product/Laptops");
    List data = repo.data['product'];
    print(data);
    List<ProductModel> listProducts = data
        .map((e) => ProductModel.fromjson(e))
        .toList();

    print(listProducts[0].images[0]);
    return listProducts;
  }
}
