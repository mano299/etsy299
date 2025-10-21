import 'dart:developer';

import 'package:dio/dio.dart';

import 'models/user_model.dart';

class User {
  static final Dio dio = Dio();

  static Future<UserModel> getUserData() async {
    var response = await dio.post(
      'https://elwekala.onrender.com/user/profile',
      data: {
        "token": "hlxam3wzh1amh0vd355",
      },
    );
    UserModel userInfo = UserModel.fromJSon(response.data['user']);
    log(response.data.toString());
    return userInfo;
  }

  static Future<void> updateUserData({
    required String name,
    required String phone,
  }) async {
    var res = await dio.put(
      "https://elwekala.onrender.com/user/update",
      data: {
        "token": "hlxam3wzh1amh0vd355",
        "name": name,
        "phone": phone,
        // الإيميل والباسورد ثابتين
        "email": "team3@gmail.com",
        "password": "team3@gmail.com",
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
      "email": "eewuw@gmail.com",
      "password": "1234567893",
    });
    log(del.data['message']);
  }
}
