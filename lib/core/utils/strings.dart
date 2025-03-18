import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Strings {
  static String apiKey = dotenv.env['API_KEY']!;
  static const String sendGridBaseUrl = 'https://api.sendgrid.com/';
  static const String sendGridEndPoint = 'v3/mail/send';

  static const String usersCollection = 'users';
  static const String productsCollection = 'products';
  static const String isVerified = 'isVerified';
}
