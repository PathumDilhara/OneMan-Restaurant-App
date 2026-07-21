import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/models/cart_model.dart';

class CartNotifier extends Notifier<List<CartModel>> {
  @override
  List<CartModel> build() {
    return [];
  }

  void addToCart(CartModel item) {
    final isExists = state.any((e) => e.foodId == item.foodId);

    if (isExists) {
      increaseQuantity(item);
    } else {
      state = [...state, item];
    }
  }

  void increaseQuantity(CartModel item) {
    state =
        state.map((e) {
          if (e.foodId == item.foodId) {
            return e.copyWith(quantity: e.quantity + item.quantity);
          }

          return e;
        }).toList();
  }

  void decreaseQuantity(String foodId) {
    state =
        state.map((e) {
          if (e.foodId == foodId && e.quantity > 1) {
            return e.copyWith(quantity: e.quantity - 1);
          }
          return e;
        }).toList();
  }

  void removeFromCart(String foodId) {
    state = state.where((e) => e.foodId != foodId).toList();
  }

  void clearCart() {
    state = [];
  }
}
