import 'package:e_commercy/core/utils/strings.dart';

class UserModel {
  String name;
  String email;
  String role;
  bool isVerified;

  UserModel({
    required this.name,
    required this.email,
    this.isVerified = false,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[Strings.name],
      email: json[Strings.email],
      isVerified: json[Strings.isVerified],
      role: json[Strings.role] ?? Strings.buyer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Strings.name: name,
      Strings.email: email,
      Strings.isVerified: false,
      Strings.role: role,
    };
  }
}
