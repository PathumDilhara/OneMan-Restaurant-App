import 'package:go_router/go_router.dart';
import 'package:oneman/features/food_details/screens/food_details_screen.dart';
import 'package:oneman/features/menu/models/food_model.dart';
import 'package:oneman/features/menu/screens/menu_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/menus",
    routes: [
      GoRoute(path: "/menus", builder: (context, state) => MenuScreen()),

      GoRoute(path: "/foodDetails", builder: (context, state) {
        final id = state.extra as String;
        return FoodDetailsScreen(id: id);
      },)
    ],
  );
}
