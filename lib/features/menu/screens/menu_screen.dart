import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/providers/category_provoider.dart';
import 'package:oneman/core/providers/food_provider.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/core/utils/svg_icon.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';
import 'package:oneman/core/widgets/shopping_cart_widget.dart';
import 'package:oneman/features/menu/widgets/food_card_widget.dart';

import '../../../core/providers/cart_provider.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  final ValueNotifier<double> _slidingValue = ValueNotifier(1700.0);
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _isBestSellers = ValueNotifier(false);
  final ValueNotifier<bool> _isSpicy = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            left: kMainPadding,
            right: kMainPadding,
            top: kMainPadding * 5,
            bottom: kMainPadding * 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main top bar
              _buildTopBar(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              SizedBox(height: 30),

              // Screen intro card
              _buildScreenIntroCard(screenWidth),
              SizedBox(height: 20),

              _buildSearchBar(),
              SizedBox(height: 20),

              // menu options
              _buildCategoryChips(),
              SizedBox(height: 20),

              // filters
              _buildFilter(),
              SizedBox(height: 20),

              // Items
              _buildItemsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // =================== WIDGETS ===================================

  Widget _buildTopBar({
    required double screenHeight,
    required double screenWidth,
  }) {
    final quantity = ref.watch(cartQuantityProvider);

    return Row(
      children: [
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(100),
        //   child: Image.asset(
        //     "assets/images/newlogoo.png",
        //     width: kLogoSize,
        //     height: kLogoSize,
        //   ),
        // ),
        SizedBox(width: 10),
        // Middle content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning UserName",
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: AppColors.primDarktGrey),
            ),
            Text(
              "What would you like?",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColors.primRed2),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded, size: 28),
        ),

        shoppingCartWidget(quantity, context),
      ],
    );
  }

  Widget _buildScreenIntroCard(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FRESH | HOT | CRISPY",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.primDarktGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Delicious ",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primDarktGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Menu",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primRed2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    final categories = ref.watch(categoryProvider);

    return categories.when(
      data:
          (data) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customButtonWidget(
                  context: context,
                  title: "All",
                  leadingIconPath: "assets/icons/restaurant_bnb.svg",
                  iconColor: AppColors.primRed1,
                  onTap: () {
                    _searchController.clear();
                    ref.read(searchProvider.notifier).clear();
                  },
                ),
                ...data.map(
                  (e) => customButtonWidget(
                    context: context,
                    title: e.name,
                    bgColor: AppColors.primWhite.withValues(alpha: 0.9),
                    leadingImageUrl: e.image,
                    onTap: () {
                      _searchController.clear();
                      ref.read(searchProvider.notifier).search(e.name);
                    },
                  ),
                ),
              ],
            ),
          ),
      error:
          (error, stackTrace) => Center(
            child: Column(
              children: [
                Icon(Icons.error, color: AppColors.primRed1, size: 100),
                SizedBox(height: 20),
                Text(
                  "Error fetching foods",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildItemsGrid() {
    final foods = ref.watch(filteredFoodProvider);
    return foods.when(
      data:
          (data) => Column(
            children: [
              Row(
                children: [
                  Text(
                    "Showing ${data.length} items",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 10),
              GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 5,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final food = data[index];

                  return foodCardWidget(context: context, food: food, ref: ref);
                },
              ),
            ],
          ),
      error:
          (error, stackTrace) => Center(
            child: Column(
              children: [
                Icon(Icons.error, color: AppColors.primRed1, size: 100),
                SizedBox(height: 20),
                Text(
                  "Error fetching foods",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildSearchBar() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kTextFieldBR),
      borderSide: BorderSide(color: Colors.transparent, width: 2),
    );
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        filled: true,
        fillColor: AppColors.primRed3.withValues(alpha: 0.1),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.primDarktGrey.withValues(alpha: 0.8),
          size: 30,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.primRed3, width: 2),
        ),
        focusedErrorBorder: border,
        hintText: "Search",
        hintStyle: TextStyle(
          fontSize: 20,
          color: AppColors.primDarktGrey.withValues(alpha: 0.8),
        ),
      ),
      onChanged: (value) {
        // Notify search notifier
        ref.read(searchProvider.notifier).search(value);
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget _buildFilter() {
    return customButtonWidget(
      context: context,
      title: "Filters",
      bgColor: AppColors.primRed1,
      titleColor: AppColors.primWhite,
      leadingIconPath: "assets/icons/filter.svg",
      iconColor: AppColors.primWhite,
      width: 100,
      onTap: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                contentPadding: EdgeInsets.all(10),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.filter_list),
                        SizedBox(width: 10),
                        Text("Filters"),
                      ],
                    ),
                    Divider(),
                  ],
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _slidingValue,
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Max price : ${_slidingValue.value.toStringAsFixed(2)}",
                            ),
                            SizedBox(height: 5),
                            Slider(
                              value: value,
                              min: 1,
                              max: 1700,
                              divisions: 1700,
                              label: value.toStringAsFixed(2),
                              onChanged: (newVal) {
                                _slidingValue.value = newVal;
                                ref
                                    .read(priceFilterProvider.notifier)
                                    .handleValue(newVal);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    Text(
                      "References",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _isSpicy,
                          builder: (context, value, child) {
                            return Checkbox(
                              value: value,
                              onChanged: (value) {
                                _isSpicy.value = value ?? false;
                              },
                            );
                          },
                        ),
                        SVGIcon(
                          icon: "assets/icons/spicy.svg",
                          color: AppColors.primRed1,
                        ),
                        Text("Spicy only"),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _isBestSellers,
                          builder: (context, value, child) {
                            return Checkbox(
                              value: value,
                              onChanged: (value) {
                                _isBestSellers.value = value ?? false;
                              },
                            );
                          },
                        ),
                        SVGIcon(
                          icon: "assets/icons/best.svg",
                          color: AppColors.primRed1,
                        ),
                        Text("Bestsellers"),
                      ],
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }
}
