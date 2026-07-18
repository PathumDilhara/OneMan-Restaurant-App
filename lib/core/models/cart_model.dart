import 'package:oneman/features/menu/models/food_model.dart';

class CartModel{
  final FoodModel food;
  final int quantity;

  CartModel({required this.food, required this.quantity});

  CartModel copyWith({int? quantity}){
    return CartModel(food: food, quantity: quantity??this.quantity);
  }
}