class UserModel {
  String name;
  String email;
  bool isVerified;

  UserModel({required this.name, required this.email, this.isVerified = false});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'isVerified': false};
  }
}
