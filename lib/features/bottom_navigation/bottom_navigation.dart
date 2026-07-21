// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/svg_icon.dart';
import 'package:oneman/features/contact/screens/contact_screen.dart';
import 'package:oneman/features/home/screens/home_screen.dart';
import 'package:oneman/features/menu/screens/menu_screen.dart';
import 'package:oneman/features/offers/screens/offers_screen.dart';
import 'package:oneman/features/profile/screens/profile_screen.dart';

import 'bottom_nav_clipper.dart';

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

  final items = [
    ["assets/icons/restaurant.svg", 0, "Menu"],
    ["assets/icons/Offers.svg", 1, "Menu"],
    ["assets/icons/phone.svg", 3, "Contact"],
    ["assets/icons/profile.svg", 4, "Profile"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
      // floatingActionButton: Transform.translate(
      //     offset: Offset(0, 5),
      //     child: homeNavItem()),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 50),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(100),
      //     child: AnimatedBottomNavigationBar.builder(
      //       backgroundColor: AppColors.primLightGrey,
      //       itemCount: 4,
      //       tabBuilder: (index, isActive) {
      //         print("############ $index");
      //         return navItem(
      //           items[index][0].toString(),
      //           index,
      //           items[index][2].toString(),
      //         );
      //       },
      //       activeIndex: _currentIndex,
      //       onTap: (index) {
      //         setState(() {
      //           _currentIndex = index;
      //         });
      //       },
      //       height: 60,
      //       gapLocation: GapLocation.center,
      //       notchSmoothness: NotchSmoothness.softEdge,
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildBottomNavBar() {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomNavClipper(),
          child: Container(
            height: 80,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.primBNB, //primLightGrey
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
                navItem("assets/icons/restaurant.svg", 0, "Menu"),
                navItem("assets/icons/percentage.svg", 1, "Offers"),
                SizedBox(width: 60),
                navItem("assets/icons/phone.svg", 3, "Contact"),
                navItem("assets/icons/profile.svg", 4, "Profile"),
              ],
            ),
          ),
        ),
        Positioned(left: 0, right: 0, top: 0, child: homeNavItem()),
      ],
    );
  }

  Widget navItem(String icon, int index, String title) {
    bool isSelected = _currentIndex == index;

    return Material(
      borderRadius: BorderRadius.circular(100),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
            },
            child: AnimatedContainer(
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
                // size: 10,
              ),
            ),
          ),

          if (isSelected) SizedBox(height: 3),
          if (isSelected)
            Text(
              title,
              style: TextStyle(
                color: AppColors.primRed2,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget homeNavItem() {
    bool isSelected = _currentIndex == 2;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = 2;
        });
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primRed1,
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? AppColors.primRed1.withValues(alpha: 0.4)
                      : Colors.transparent,
              blurRadius: 5,
              spreadRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: SVGIcon(
            icon: "assets/icons/home.svg",
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
