import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oneman/core/models/food_model.dart';
import 'package:oneman/core/providers/food_provider.dart';
import 'package:oneman/core/router/router_paths.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';
import 'package:oneman/core/widgets/shopping_cart_widget.dart';

import '../../../core/providers/cart_provider.dart';

class OffersScreen extends ConsumerStatefulWidget {
  const OffersScreen({super.key});

  @override
  ConsumerState<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends ConsumerState<OffersScreen> {
  final PageController _promoController = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodAsync = ref.watch(menuFoodProvider);
    final quantity = ref.watch(cartQuantityProvider);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: kMainPadding,
          right: kMainPadding,
          top: kMainPadding * 5,
          bottom: kMainPadding * 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(quantity),
            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPromoSlider(),
                    SizedBox(height: kMainPadding * 3),

                    _buildSectionHeader("Exclusive Offers"),
                    SizedBox(height: kMainPadding * 2),

                    foodAsync.when(
                      data: (foods) {
                        final offers =
                            foods.where((f) => f.isSpecialOffer).toList();
                        if (offers.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Text("No special offers available today!"),
                            ),
                          );
                        }
                        return _buildOffersGrid(offers);
                      },
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (err, stack) =>
                              Center(child: Text("Error loading offers: $err")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int cartQuantity) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Special Deals",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primRed2,
              ),
            ),
            Text(
              "Grab your favorites at low prices",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.primDarktGrey),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded, size: 28),
        ),
        shoppingCartWidget(cartQuantity, context),
      ],
    );
  }

  Widget _buildPromoSlider() {
    return SizedBox(
      height: 160,
      child: PageView(
        controller: _promoController,
        children: [
          _buildPromoCard(
            title: "FLASH SALE",
            subtitle: "Up to 50% OFF on selected items",
            color1: AppColors.primRed1,
            color2: AppColors.primRed3,
            icon: Icons.bolt,
          ),
          _buildPromoCard(
            title: "BUY 1 GET 1",
            subtitle: "On all family size pizzas",
            color1: Colors.orange.shade800,
            color2: Colors.orange.shade900,
            icon: Icons.local_pizza_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard({
    required String title,
    required String subtitle,
    required Color color1,
    required Color color2,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color1.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              icon,
              size: 120,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "LIMITED TIME",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildOffersGrid(List<dynamic> offers) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: offers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final food = offers[index];
        return _buildOfferCard(food);
      },
    );
  }

  Widget _buildOfferCard(FoodModel food) {
    final price = food.price.toStringAsFixed(2);

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(RouterPaths.foodDetails, extra: food.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: food.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primRed1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "OFFER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "LKR $price",
                        style: TextStyle(
                          color: AppColors.primRed2,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if (food.discountAmount > 0) ...[
                        const SizedBox(width: 4),
                        Text(
                          "${food.price + food.discountAmount}",
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium!.copyWith(
                            color: AppColors.primDarktGrey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        food.rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      customButtonWidget(
                        context: context,
                        title: "add",
                        bgColor: AppColors.primRed2,
                        titleColor: AppColors.primWhite,
                        trailingIcon: "assets/icons/add.svg",
                        iconColor: AppColors.primWhite,
                        onTap: () {},
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
}
