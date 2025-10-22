import 'package:dio/dio.dart';
import 'package:etsy/features/card/model/card_model.dart';

class CardData {
  final Dio dio = Dio();

  addCart({required String productId}) async {
    var repoo = await dio.post(
      'https://elwekala.onrender.com/cart/add',
      data: {
        "nationalId": "01210567022258",
        "productId": productId,
        "quantity": "1",
      },
    );
    var data = repoo.data;
    print(data);
  }

  getCard() async {
    var repoo = await dio.get(
      'https://elwekala.onrender.com/cart/allProducts',
      data: {"nationalId": "01210567022258"},
    );

    List data = repoo.data['products'];
    List<CardModel> cardModel = data.map((e) => CardModel.fromdata(e)).toList();
    return cardModel;
  }

  getData({required String id}) async {
    var repoo = await dio.delete(
      'https://elwekala.onrender.com/cart/delete',
      data: {"nationalId": "01210567022258", "productId": id},
    );
    var data = repoo.data;
    print(data);
  }

  updateData({required String productId, required num quantity}) async {
    var repoo = await dio.put(
      'https://elwekala.onrender.com/cart',
      data: {
        "nationalId": "01210567022258",
        "productId": productId,
        "quantity": quantity,
      },
    );
    var data = repoo.data;
    print(data);
  }
}
