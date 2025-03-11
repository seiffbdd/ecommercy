import 'package:dio/dio.dart';
import 'package:e_commercy/core/utils/strings.dart';

class DioHelper {
  late Dio dio;

  DioHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: Strings.sendGridBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20),
      ),
    );
  }

  Future post({required String endPoint, Object? data}) async {
    dio.options.headers['Authorization'] = Strings.apiKey;
    dio.options.headers['Content-Type'] = 'application/json';

    return await dio.post(endPoint, data: data);
  }
}
