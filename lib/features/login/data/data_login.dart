import 'package:dio/dio.dart';
import 'package:etsy/core/shared.dart';
import 'package:etsy/features/login/model/model_login.dart';

class LoginData {
  static login({required String email, required String password}) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://elwekala.onrender.com/user/login',
      data: {"email": email, "password": password},
    );
    var data = response.data;
    var model = LoginModel.fromJson(data);
    var token = data['user']['token'];
    Shared.setString(key: "TOKEN", value: token);
    Shared.setString(key: "PASS", value: password);
    Shared.setString(key: "EMAIL", value: email);
    return model;
  }

  static registerData({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String nationalId,
    required String gender,
    required String profileImage,
  }) async {
    Dio dio = Dio();
    try {
      var response = await dio.post(
        'https://elwekala.onrender.com/user/register',
        data: {
          "email": email,
          "password": password,
          "name": name,
          "phone": phone,
          "nationalId": nationalId,
          "gender": gender,
          "profileImage": profileImage,
        },
      );
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        return {"status": "error", "message": "Unexpected response format"};
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return e.response!.data;
      } else {
        return {"status": "error", "message": e.message ?? "Unknown error"};
      }
    }
  }
}
