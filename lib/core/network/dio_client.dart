import 'package:dio/dio.dart';
import 'package:oneman/core/network/api_constants.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: 5),

        receiveTimeout: Duration(seconds: 5),

        headers: {"Content-Type": "application/json"},
      ),
    );
  }
}
