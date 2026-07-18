import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/models/cart_model.dart';
import 'package:oneman/core/providers/menu_provider.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/features/menu/models/food_model.dart';

import '../../../core/utils/colors.dart';
import '../../../core/widgets/custom_button_widget.dart';

class FoodDetailsScreen extends ConsumerWidget {
  final FoodModel food;
  FoodDetailsScreen({super.key, required this.food});
  final ValueNotifier<int> _quantity = ValueNotifier(1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: food.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Positioned(
                  right: 30,
                  bottom: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primWhite.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_quantity.value > 1) {
                              _quantity.value--;
                            }
                          },
                          icon: Icon(Icons.remove),
                        ),
                        SizedBox(width: 10),
                        ValueListenableBuilder(
                          valueListenable: _quantity,
                          builder: (context, value, child) {
                            return Text(_quantity.value.toString());
                          },
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            _quantity.value++;
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(kMainPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.green.shade800),
                            SizedBox(width: 5),

                            Text(
                              food.rating.toString(),
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Description
                  Text(
                    food.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Price + Add button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "RS. ${food.price}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primRed3,
                fontWeight: FontWeight.bold,
              ),
            ),

            customButtonWidget(
              context: context,
              title: "Add",
              onTap: () {
                print("### Add ${food.name}");
                ref
                    .watch(cartProvider.notifier)
                    .addToCart(CartModel(food: food, quantity: _quantity.value));
              },
              trailingIcon: "assets/icons/add.svg",
              bgColor: AppColors.primRed1,
              titleColor: AppColors.primWhite,
              iconColor: AppColors.primWhite,
              borderColor: Colors.transparent,
              width: 100,
              height: 40
            ),
          ],
        ),
      ),
    );
  }
}
