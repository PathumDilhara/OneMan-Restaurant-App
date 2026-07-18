import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/providers/dio_provider.dart';
import 'package:oneman/features/menu/models/food_model.dart';
import 'package:oneman/features/menu/services/api_service.dart';

final menuAPIServiceProvider = Provider<MenuAPIService>((ref) {
  final dio = ref.read(dioProvider);
  return MenuAPIService(dio: dio);
});

final menuFoodProvider = FutureProvider<List<FoodModel>>((ref) async {
  final service = ref.read(menuAPIServiceProvider);
  return service.fetchFood();
});
