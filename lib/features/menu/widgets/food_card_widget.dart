import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oneman/core/models/cart_model.dart';
import 'package:oneman/core/providers/food_provider.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';

import '../models/food_model.dart';

Widget foodCardWidget({
  required BuildContext context,
  required FoodModel food,
  required WidgetRef ref,
}) {
  return InkWell(
    onTap: () {
      print("### Navigating");
      GoRouter.of(context).push("/foodDetails", extra: food.id);
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: food.image,
              placeholder:
                  (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget:
                  (context, url, error) => Icon(Icons.error, color: Colors.red),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        food.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.greenAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.star, color: Colors.green.shade800),
                          Text(
                            food.rating.toString(),
                            style: TextStyle(color: Colors.green.shade800),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),

                Text(
                  food.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "RS. ${food.price}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.primRed3,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Flexible(
                      child: customButtonWidget(
                        context: context,
                        title: "Add",
                        onTap: () {
                          print("### food adding");
                          ref
                              .watch(cartProvider.notifier)
                              .addToCart(CartModel(foodId: food.id, quantity: 1));
                        },
                        trailingIcon: "assets/icons/add.svg",
                        bgColor: AppColors.primRed1,
                        titleColor: AppColors.primWhite,
                        iconColor: AppColors.primWhite,
                        borderColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
