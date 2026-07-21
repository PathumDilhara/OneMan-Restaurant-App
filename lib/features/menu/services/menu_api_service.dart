import 'package:dio/dio.dart';
import 'package:oneman/core/loggor/loggor.dart';
import 'package:oneman/core/models/food_model.dart';

class MenuAPIService {
  final Dio dio;

  MenuAPIService({required this.dio});

  Future<List<FoodModel>> fetchFood() async {
    try {
      appLogger.i("### fetching");
      final response = await dio.get("/menus");
      final data = response.data;
      appLogger.i(response.statusCode);
      // print("Response Data foods:${response.data}");

      List<dynamic> foodsDict = data['data'];

      List<FoodModel> foods =
          foodsDict.map((e) => FoodModel.fromJson(e)).toList();

      return foods;
    } catch (err, stack) {
      appLogger.e("ERROR: $err");
      appLogger.e(stack);
      rethrow;
    }
  }
}
