import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://onemansys.vampior.com/api",
        connectTimeout: Duration(seconds: 5),

        receiveTimeout: Duration(seconds: 5),

        headers: {"Content-Type": "application/json"},
      ),
    );
  }
}
