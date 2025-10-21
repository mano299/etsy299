class UserModel {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String gender;
  final String profileImage;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.gender,
    required this.profileImage,
  });
  factory UserModel.fromJSon(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      nationalId: json['nationalId'],
      gender: json['gender'],
      profileImage: json['profileImage'],
    );
  }
}
