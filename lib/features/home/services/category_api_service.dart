import 'package:dio/dio.dart';
import 'package:oneman/core/models/categoty_model.dart';

import '../../../core/loggor/loggor.dart';

class CategoryApiService{

  final Dio dio;

  CategoryApiService({required this.dio});

  Future<List<CategoryModel>> fetchCategories()async{
    try {
      appLogger.i("fetching categories");
      final response = await dio.get("/categories");
      final data = response.data;
      appLogger.i(response.statusCode);

      List<dynamic> foodsDict = data['data'];

      List<CategoryModel> foods =
      foodsDict.map((e) => CategoryModel.fromJson(e)).toList();

      return foods;
    } catch (err, stack){
      appLogger.e("ERROR: $err");
      appLogger.e(stack);
      rethrow;
    }
  }
}