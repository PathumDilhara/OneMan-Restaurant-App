import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/models/cart_model.dart';

class CartNotifier extends Notifier<List<CartModel>> {
  @override
  List<CartModel> build() {
    return [];
  }

  void addToCart(CartModel item) {
    final isExists = state.any((e) => e.food.id == item.food.id);

    if (isExists) {
      increaseQuantity(item);
    } else {
      state = [...state, item];
    }
  }

  void increaseQuantity(CartModel item) {
    state =
        state.map((e) {
          if (e.food.id == item.food.id) {
            return e.copyWith(quantity: e.quantity + item.quantity);
          }

          return e;
        }).toList();
  }
}
