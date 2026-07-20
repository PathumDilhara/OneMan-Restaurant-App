import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/models/categoty_model.dart';
import 'package:oneman/core/providers/dio_provider.dart';
import 'package:oneman/features/home/services/category_api_service.dart';

final categoryServiceProvider = Provider<CategoryApiService>((ref) {
  final dio = ref.read(dioProvider);
  return CategoryApiService(dio: dio);
});

final categoryProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final service = ref.read(categoryServiceProvider);
  return service.fetchCategories();
});
