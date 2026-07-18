import 'package:dio/dio.dart';
import 'package:oneman/features/menu/models/food_model.dart';

class MenuAPIService {
  final Dio dio;

  MenuAPIService({required this.dio});

  Future<List<FoodModel>> fetchFood() async {
    try {
      print("### fetching");
      final response = await dio.get("/menus");
      final data = response.data;
      print(response.statusCode);
      print("Response Data foods:${response.data}");

      List<dynamic> foodsDict = data['data'];

      List<FoodModel> foods =
          foodsDict.map((e) => FoodModel.fromJson(e)).toList();

      print("### \n $foods");
      return foods;

    } catch (err, stack) {
      print("ERROR: $err");
      print(stack);
      rethrow;
    }
  }
}
