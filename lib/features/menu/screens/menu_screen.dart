import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/providers/menu_provider.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';
import 'package:oneman/features/menu/widgets/food_card_widget.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  final ValueNotifier<double> _slidingValue = ValueNotifier(100);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(kMainPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main top bar
              _buildTopBar(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              SizedBox(height: 30),

              // Screen details
              _buildDetailsBar(screenWidth),
              SizedBox(height: 20),

              // menu options
              _buildMenuChips(),
              SizedBox(height: 20),

              // filters
              _buildFilter(),
              SizedBox(height: 20),

              // Items
              Row(
                children: [
                  Text(
                    "Showing 2 items",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 10),
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
    return Padding(
      padding: EdgeInsets.only(top: kMainPadding * 3),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset("assets/images/newlogoo.png", width: 60),
          ),
          SizedBox(width: 10),

          _buildSearchBar(),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildDetailsBar(double screenWidth) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [AppColors.primRed1, AppColors.primRed2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            "FRESH | HOT | CRISPY",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: AppColors.primGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 3),

          Text(
            "Our Menu",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.primGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 3),

          Text(
            "Handpicked favorites made fresh to order.",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: AppColors.primGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuChips() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 20,
      children: <Widget>[
        customButtonWidget(
          context: context,
          title: "All",
          leadingIcon: "assets/icons/restaurant.svg",
          bgColor: AppColors.primWhite.withValues(alpha: 0.9),
          onTap: () {},
        ),
        customButtonWidget(
          context: context,
          title: "Burgers",
          leadingIcon: "assets/icons/burger.svg",
          bgColor: AppColors.primWhite.withValues(alpha: 0.9),
          onTap: () {},
        ),
        customButtonWidget(
          context: context,
          title: "Pizza",
          leadingIcon: "assets/icons/pizza.svg",
          bgColor: AppColors.primWhite.withValues(alpha: 0.9),
          onTap: () {},
        ),
        customButtonWidget(
          context: context,
          title: "Cake",
          leadingIcon: "assets/icons/cake.svg",
          bgColor: AppColors.primWhite.withValues(alpha: 0.9),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildItemsGrid() {
    final foods = ref.watch(menuFoodProvider);
    return foods.when(
      data:
          (data) => GridView.builder(
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

              return foodCardWidget(
                context: context,
                url: food.image,
                title: food.name,
                description: food.description,
                price: food.price,
                rating: food.rating,
              );
            },
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
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey),
    );
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: border,
          enabledBorder: border,
          focusedErrorBorder: border,
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildFilter() {
    return customButtonWidget(
      context: context,
      title: "Filters",
      bgColor: AppColors.primRed1,
      titleColor: AppColors.primWhite,
      leadingIcon: "assets/icons/filter.svg",
      iconColor: AppColors.primWhite,
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
                        Checkbox(value: false, onChanged: (value) {}),
                        Icon(Icons.icecream),
                        Text("Spicy only"),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Icon(Icons.start),
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
