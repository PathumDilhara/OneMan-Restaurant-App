import 'package:go_router/go_router.dart';
import 'package:oneman/core/router/router_paths.dart';
import 'package:oneman/features/cart/screens/cart_screen.dart';
import 'package:oneman/features/food_details/screens/food_details_screen.dart';
import 'package:oneman/features/menu/screens/menu_screen.dart';

import '../../features/bottom_navigation/bottom_navigation.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouterPaths.bnb,
    routes: [

      GoRoute(
        path: RouterPaths.bnb,
        builder: (context, state) => BottomNavigationScreen(),
      ),

      GoRoute(
        path: RouterPaths.menu,
        builder: (context, state) => MenuScreen(),
      ),

      GoRoute(
        path: RouterPaths.cart,
        builder: (context, state) => CartScreen(),
      ),

      GoRoute(
        path: RouterPaths.foodDetails,
        builder: (context, state) {
          final id = state.extra as String;
          return FoodDetailsScreen(id: id);
        },
      ),
    ],
  );
}
