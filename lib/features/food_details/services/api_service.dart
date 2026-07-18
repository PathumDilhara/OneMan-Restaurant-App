import 'package:dio/dio.dart';

import '../models/food_details_model.dart';

class FoodDetailsAPIService {

  final Dio dio;

  FoodDetailsAPIService({required this.dio});

  Future<FoodDetailsModel> fetchFoodDetailsById(String id) async {
    try {
      print("### fetching");
      final response = await dio.get("/menus/$id");
      final data = response.data;
      print(response.statusCode);

      final foodsDict = data['data'];

      FoodDetailsModel food = FoodDetailsModel.fromJson(foodsDict);

      return food;
    } catch (err, stack) {
      print("### Error : $err");
      print(stack);
      rethrow;
    }
  }
}