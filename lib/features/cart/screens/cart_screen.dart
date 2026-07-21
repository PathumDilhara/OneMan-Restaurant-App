import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oneman/core/models/cart_model.dart';
import 'package:oneman/core/models/food_model.dart';
import 'package:oneman/core/providers/food_provider.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';

import '../../../core/providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final allFoods = ref.watch(menuFoodProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primDark),
        ),
        title: Text(
          "My Cart",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primDark,
          ),
        ),
        // centerTitle: true,
      ),
      body:
          cartItems.isEmpty
              ? _buildEmptyState(context)
              : _buildCartNonEmpty(context, ref, cartItems, allFoods),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: AppColors.primGrey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 20),
          Text(
            "Your cart is empty",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.primDarkGrey),
          ),
          const SizedBox(height: 30),
          customButtonWidget(
            context: context,
            title: "Browse Menu",
            bgColor: AppColors.primRed1,
            titleColor: AppColors.primWhite,
            width: 200,
            height: 50,
            onTap: () => GoRouter.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildCartNonEmpty(
    BuildContext context,
    WidgetRef ref,
    List<CartModel> cartItems,
    AsyncValue<List<FoodModel>> allFoods,
  ) {
    return Column(
      children: [
        Expanded(
          child: allFoods.when(
            data: (foods) {
              return ListView.builder(
                padding: EdgeInsets.all(kMainPadding),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final CartModel cartItem = cartItems[index];
                  final food = foods.firstWhere((f) => f.id == cartItem.foodId);
                  return _buildCartItem(context, ref, cartItem, food);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text("Error: $e")),
          ),
        ),
        _buildOrderSummary(context, ref, cartItems, allFoods),
      ],
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    WidgetRef ref,
    CartModel cartItem,
    dynamic food,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primRed2.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: food.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "LKR ${food.price}",
                  style: TextStyle(
                    color: AppColors.primRed2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed:
                    () =>
                        ref.read(cartProvider.notifier).removeFromCart(food.id),
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.primRed1,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildQtyBtn(
                    icon: Icons.remove,
                    onTap: () {
                      if (cartItem.quantity == 1) {
                        ref.read(cartProvider.notifier).removeFromCart(food.id);
                      } else {
                        ref
                            .read(cartProvider.notifier)
                            .decreaseQuantity(food.id);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      cartItem.quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildQtyBtn(
                    icon: Icons.add,
                    onTap:
                        () => ref
                            .read(cartProvider.notifier)
                            .increaseQuantity(cartItem),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.primRed2,
          border: Border.all(color: AppColors.primRed2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.primWhite),
      ),
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> cartItems,
    AsyncValue<List<dynamic>> allFoods,
  ) {
    return allFoods.maybeWhen(
      data: (foods) {
        double subtotal = 0;
        for (var item in cartItems) {
          final food = foods.firstWhere((f) => f.id == item.foodId);
          subtotal += food.price * item.quantity;
        }
        double delivery = 0.0; // Simulated delivery fee
        double total = subtotal + delivery;

        return Container(
          padding: EdgeInsets.all(kMainPadding * 2),
          decoration: BoxDecoration(
            color: AppColors.primWhite,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSummaryRow(
                "Subtotal",
                "LKR ${subtotal.toStringAsFixed(2)}",
              ),
              const SizedBox(height: 8),
              _buildSummaryRow(
                "Delivery Fee",
                "LKR ${delivery.toStringAsFixed(2)}",
              ),
              const Divider(height: 24),
              _buildSummaryRow(
                "Total",
                "LKR ${total.toStringAsFixed(2)}",
                isTotal: true,
              ),
              const SizedBox(height: 20),
              customButtonWidget(
                context: context,
                title: "Checkout",
                bgColor: AppColors.primRed2,
                titleColor: AppColors.primWhite,
                height: 55,
                onTap: () {
                  // Simulate checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order placed successfully!")),
                  );
                  ref.read(cartProvider.notifier).clearCart();
                  context.pop();
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? AppColors.primDark : AppColors.primDarkGrey,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? AppColors.primRed2 : AppColors.primDark,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
      ],
    );
  }
}
