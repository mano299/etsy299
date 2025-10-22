import 'package:dio/dio.dart';
import 'fav_model.dart';

//obj from dio
final Dio dio=Dio();

class FavData{

  //fun to get all data
  static Future<List<FavModel>>getAllData() async{
    try
    {
      //const var
      var shirtUrl="https://dummyjson.com/products/category/mens-shirts";
      var electUrl="https://fakestoreapi.com/products/category/electronics";
      var LapUrl ="https://elwekala.onrender.com/product/Laptops";

      //variable to carry the data(json body)...........
      var shirtRepo= await dio.get("https://dummyjson.com/products/category/mens-shirts");
      var electRepo= await dio.get("https://fakestoreapi.com/products/category/electronics");
      var LapRepo= await dio.get("https://elwekala.onrender.com/product/Laptops");

      //var to carry only data not all json body............
      var shirtData=shirtRepo.data;
      var electData=electRepo.data;
      var LaptData=LapRepo.data;

      var allData = [
        ...(shirtData['products'] ?? []),
        ...(electData is List ? electData : []),
        ...(LaptData['products'] ?? []),
      ];

      // make a list from model
      List<FavModel> products = allData.map((json) => FavModel.fromjson(json)).toList();
      return products;
    }
    catch(err)
    {
      print('Error Loading Data: $err');
      return [];
    }
  }
}