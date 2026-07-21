import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_model.dart';
import 'notifiers/cart_notifier.dart';

final cartProvider = NotifierProvider<CartNotifier, List<CartModel>>(
  CartNotifier.new,
);

final cartQuantityProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);

  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});
