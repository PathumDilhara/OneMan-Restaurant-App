import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/providers/dio_provider.dart';
import 'package:oneman/core/providers/notifiers/price_filter_notifier.dart';
import 'package:oneman/core/providers/notifiers/search_notifer.dart';
import 'package:oneman/features/food_details/models/food_details_model.dart';
import 'package:oneman/features/food_details/services/api_service.dart';
import 'package:oneman/core/models/food_model.dart';
import 'package:oneman/features/menu/services/menu_api_service.dart';

// Provider for Service layer connection
final menuAPIServiceProvider = Provider<MenuAPIService>((ref) {
  final dio = ref.read(dioProvider);
  return MenuAPIService(dio: dio);
});

// Provider for fetching all foods
final menuFoodProvider = FutureProvider<List<FoodModel>>((ref) async {
  final service = ref.read(menuAPIServiceProvider);
  return service.fetchFood();
});

// Provider for getting search result
final searchProvider = NotifierProvider<SearchNotifier, String>(
  SearchNotifier.new,
);

final priceFilterProvider = NotifierProvider<PriceFilterNotifier, double>(
  PriceFilterNotifier.new,
);

final filteredFoodProvider = Provider<AsyncValue<List<FoodModel>>>((ref) {
  // read is ok for now but in future if there is a refresh or invalidation
  // of menu provider state and updates food list then it will never notifier
  // this filter provider if we used read instead watch
  // if we use watch filteredFoodProvider depends on menuFoodProvider updates happens
  final foodAsync = ref.watch(menuFoodProvider);
  final query = ref.watch(searchProvider);
  final price = ref.watch(priceFilterProvider);

  return foodAsync.whenData((foods) {
    // if query empty let return entire food list
    // if (query.trim().isEmpty) {
    //   return foods;
    // }

    // searching
    return foods.where((food) {
      final isSearchMatches =
          query.trim().isEmpty ||
          food.name.toLowerCase().contains(query.toLowerCase()) ||
          food.category.toLowerCase().contains(query.toLowerCase());
      final isPriceMatch = price == 0.0 || food.price <= price;

      return isSearchMatches && isPriceMatch;
    }).toList();
  });
});

// user types 'bur' >>> onChange updates the SearchNotifier state through searchProvider
// >>> then searchProvider state changes >>> filteredFoodProvider is watching searchProvider
// then  filteredFoodProvider rebuild and do the filtering logic >>>
// UI GridView is watching filteredFoodProvider
// GridView rebuilds with the filtered result



final foodDetailsServiceProvider = Provider<FoodDetailsAPIService>((ref) {
  final dio = ref.read(dioProvider);
  return FoodDetailsAPIService(dio: dio);
});

final foodDetailsProvider = FutureProvider.family<FoodDetailsModel, String>((
  ref,
  id,
) async {
  final service = ref.read(foodDetailsServiceProvider);
  return service.fetchFoodDetailsById(id);
});
