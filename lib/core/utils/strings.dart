import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Strings {
  static String apiKey = dotenv.env['API_KEY']!;
  static const String sendGridBaseUrl = 'https://api.sendgrid.com/';
  static const String sendGridEndPoint = 'v3/mail/send';

  static const String usersCollection = 'users';
  static const String productsCollection = 'products';
  static const String isVerified = 'isVerified';
  static const String category = 'category';
  static const String buyer = 'buyer';
  static const String seller = 'seller';
  static const String name = 'name';
  static const String email = 'email';
  static const String role = 'role';
  static const String isGuest = 'isGuest';
}
