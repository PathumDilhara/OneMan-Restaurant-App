import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneman/core/router/router_paths.dart';
import '../utils/colors.dart';

Widget shoppingCartWidget(int quantity, BuildContext context) {
  return IconButton(
    onPressed: () {
      GoRouter.of(context).push(RouterPaths.cart);
    },
    icon: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16, right: 20),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.primRed3,
            size: 25,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: AppColors.primRed1,
            ),
            child: Center(
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
