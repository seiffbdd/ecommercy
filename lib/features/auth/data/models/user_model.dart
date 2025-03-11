class UserModel {
  String name;
  String email;
  String password;
  bool isVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'isVerified': false,
    };
  }
}
