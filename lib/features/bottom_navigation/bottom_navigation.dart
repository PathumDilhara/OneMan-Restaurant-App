import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/svg_icon.dart';
import 'package:oneman/features/contact/screens/contact_screen.dart';
import 'package:oneman/features/home/screens/home_screen.dart';
import 'package:oneman/features/menu/screens/menu_screen.dart';
import 'package:oneman/features/offers/screens/offers_screen.dart';
import 'package:oneman/features/profile/screens/profile_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 2;

  late List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      MenuScreen(),
      OffersScreen(),
      HomeScreen(),
      ContactScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[_currentIndex],

          // bottom nav bar
          Positioned(
            left: 10,
            right: 10,
            bottom: 30,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primLightGrey,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: AppColors.primGrey,
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navItem("assets/icons/restaurant.svg", 0),
          navItem("assets/icons/percentage.svg", 1),
          navItem("assets/icons/home.svg", 2),
          navItem("assets/icons/phone.svg", 3),
          navItem("assets/icons/profile.svg", 4),
        ],
      ),
    );
  }

  Widget navItem(String icon, int index) {
    bool isSelected = _currentIndex == index;

    return Material(
      borderRadius: BorderRadius.circular(100),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          children: [
            AnimatedContainer(
              padding: EdgeInsets.all(10),
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:
                    isSelected
                        ? AppColors.primRed1.withValues(alpha: 0.3)
                        : Colors.transparent,
              ),
              child: SVGIcon(
                icon: icon,
                color: isSelected ? AppColors.primRed2 : Colors.grey.shade800,
                size: 25,
              ),
            ),
            if (isSelected) SizedBox(height: 3),
            if (isSelected)
              Text(
                "Home",
                style: TextStyle(color: AppColors.primRed2, fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}
