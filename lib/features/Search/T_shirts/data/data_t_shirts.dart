import 'package:dio/dio.dart';
import 'package:etsy/features/Search/T_shirts/data/model_t_shirts.dart';

class DataTShirts {
  static Future<List<ModelTShirts>> getDataTShirts() async {
    // Dio dio = Dio();
    // var repo = await dio.get(
    //   "https://dummyjson.com/products/category/mens-shirts",
    // );
    // List data = repo.data['products'];
    // print(data);
    // List<ModelTShirts> listTShirts = data
    //     .map((e) => ModelTShirts.fromJson(e))
    //     .toList();
    // print(listTShirts[0].thumbnail);

    // return listTShirts;

    try {
      Dio dio = Dio();
      var repo = await dio.get(
        "https://dummyjson.com/products/category/mens-shirts",
      );
      List data = repo.data['products'];
      List<ModelTShirts> listTShirts = data
          .map((e) => ModelTShirts.fromJson(e))
          .toList();
      return listTShirts;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
