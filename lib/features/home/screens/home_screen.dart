import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/providers/category_provoider.dart';
import 'package:oneman/core/providers/food_provider.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';
import 'package:oneman/core/widgets/shopping_cart_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PageController _promoController = PageController(
    viewportFraction: 0.92,
  );

  @override
  void dispose() {
    _locationController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: kMainPadding,
          right: kMainPadding,
          top: kMainPadding * 6,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHomeHeader(),
              const SizedBox(height: 24),

              _buildDeliveryCard(),
              const SizedBox(height: 28),

              _buildPromoBanner(),
              const SizedBox(height: 28),

              _buildCategoryRow(),
              const SizedBox(height: 24),

              _buildSectionHeader("Popular Now", onSeeAll: () {}),
              const SizedBox(height: 12),

              _buildPopularPlaceholder(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- HEADER ----------
  Widget buildHomeHeader() {
    final quantity = ref.watch(cartQuantityProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar with gradient ring + online dot
        Container(
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.primRed1, AppColors.primRed2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kLogoSize),
            child: Container(
              color: AppColors.primWhite,
              padding: const EdgeInsets.all(2),
              child: Image.asset(
                "assets/images/newlogoo.png",
                fit: BoxFit.contain,
                width: kLogoSize,
                height: kLogoSize,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back 👋",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.primDarktGrey),
            ),
            const SizedBox(height: 2),
            Text(
              "User Name", // TODO
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded, size: 25),
        ),
        shoppingCartWidget(quantity),
      ],
    );
  }

  // ---------- DELIVERY SEARCH CARD ----------
  Widget _buildDeliveryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.primWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.play_circle_outline_outlined,
                color: AppColors.primRed1,
              ),
              const SizedBox(width: 12),
              Text(
                "Start your order here",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primGrey,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.gps_fixed, color: AppColors.primRed2),
                          const SizedBox(width: 10),
                          Icon(Icons.map_outlined, color: AppColors.primRed2),
                          const SizedBox(width: 10),
                        ],
                      ),
                      filled: true,
                      fillColor: AppColors.primWhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: AppColors.primDarktGrey.withOpacity(0.2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: AppColors.primDarktGrey.withOpacity(0.15),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      hintText: "Enter your delivery location",
                      hintStyle: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(color: AppColors.primGrey),
                    ),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    validator: (value) {
                      if (_locationController.text.isEmpty) {
                        return "Location should not be empty";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(width: kMainPadding),
              customButtonWidget(
                context: context,
                title: "Search",
                height: 50,
                br: 10,
                bgColor: AppColors.primRed2,
                titleColor: AppColors.primWhite,
                leadingIcon: "assets/icons/search.svg",
                iconColor: AppColors.primWhite,
                onTap: () {
                  _formKey.currentState!.validate();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO
  // ---------- PROMO BANNER (signature element) ----------
  Widget _buildPromoBanner() {
    return SizedBox(
      height: 130,
      child: PageView(
        controller: _promoController,
        children: [
          _promoCard(
            title: "30% OFF",
            subtitle: "On your first order today",
            icon: Icons.local_offer_outlined,
          ),
          _promoCard(
            title: "Free Delivery",
            subtitle: "Orders above LKR 2,000",
            icon: Icons.delivery_dining_outlined,
          ),
        ],
      ),
    );
  }

  Widget _promoCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [AppColors.primRed1, AppColors.primRed2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              icon,
              size: 90,
              color: AppColors.primWhite.withValues(alpha: 0.15),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.primWhite,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.primWhite.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- CATEGORY ROW ----------
  Widget _buildCategoryRow() {
    final categories = ref.watch(categoryProvider);
    return SizedBox(
      height: 110,
      child: categories.when(
        data:
            (data) => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final cat = data[index];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: cat.image,
                        fit: BoxFit.cover,
                        width: 56,
                        height: 56,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: SizedBox(
                        width: 60,
                        child: Text(
                          cat.name,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
        error:
            (error, stackTrace) => Center(
              child: Column(
                children: [
                  Icon(Icons.error, color: AppColors.primRed1, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Error fetching foods",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  // ---------- SECTION HEADER ----------
  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text("See all", style: TextStyle(color: AppColors.primRed2)),
        ),
      ],
    );
  }

  // ---------- POPULAR ITEMS (wire to your food_provider) ----------
  Widget _buildPopularPlaceholder() {
    final foods = ref.watch(filteredFoodProvider);

    return foods.when(
      data:
          (data) => SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final food = data[index];

                return Container(
                  width: 140,
                  decoration: BoxDecoration(
                    color: AppColors.primWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.primRed1.withValues(alpha: 0.08),
                          borderRadius:  BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          child: CachedNetworkImage(
                            imageUrl: food.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "LKR ${food.price}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(
                                color: AppColors.primRed2,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      error: (error, stackTrace) => Center(),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
