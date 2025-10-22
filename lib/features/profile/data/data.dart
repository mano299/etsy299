import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:etsy/features/core/constants.dart';

import 'models/user_model.dart';

class User {
  static final Dio dio = Dio();

  static Future<UserModel> getUserData() async {
    var response = await dio.post(
      'https://elwekala.onrender.com/user/profile',
      data: {
        "token": kToken,
      },
    );
    UserModel userInfo = UserModel.fromJSon(response.data['user']);
    log(response.data.toString());
    return userInfo;
  }

  static Future<void> updateUserData({
    required String name,
    required String phone,
    required String email,
  }) async {
    var res = await dio.put(
      "https://elwekala.onrender.com/user/update",
      data: {
        "token": kToken,
        "name": name,
        "phone": phone,
        // الإيميل والباسورد ثابتين
        "email": email,
        "password": kPassword,
      },
    );

    log(res.data.toString());

    await getUserData();
  }

  static deleteUser({
    required String email,
    required String password,
  }) async {
    var del =
        await dio.delete("https://elwekala.onrender.com/user/delete", data: {
      "email": email,
      "password": password,
    });
    log(del.data['message']);
  }
}
