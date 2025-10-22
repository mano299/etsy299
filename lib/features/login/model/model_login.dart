class LoginModel {
  final String message;
  final String status;
  LoginModel({required this.message, required this.status});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      status: json['status'],
     );
  }
}