class CartModel {
  final String foodId;
  final int quantity;

  CartModel({required this.foodId, required this.quantity});

  CartModel copyWith({int? quantity}) {
    return CartModel(foodId: foodId, quantity: quantity ?? this.quantity);
  }
}
