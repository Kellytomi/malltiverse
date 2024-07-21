import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final int cartItemCount;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.cartItemCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(context, 0, 'assets/icons/home.png'),
          _buildNavBarItem(context, 1, 'assets/icons/cart1.png', showCounter: true),
          _buildNavBarItem(context, 2, 'assets/icons/checkout1.png'),
          _buildNavBarItem(context, 3, 'assets/icons/profile.png'),  // Update index for profile icon
        ],
      ),
    );
  }

  Widget _buildNavBarItem(BuildContext context, int index, String assetPath, {bool showCounter = false}) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: selectedIndex == index ? const Color(0xFFFF7F7D) : Colors.transparent,
            child: Image.asset(
              assetPath,
              color: selectedIndex == index ? Colors.black : Colors.white,
            ),
          ),
          if (showCounter && cartItemCount > 0)
            Positioned(
              right: 0,
              child: badges.Badge(
                badgeContent: Text(
                  '$cartItemCount',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                badgeColor: Colors.red,
                child: Container(),
              ),
            ),
        ],
      ),
    );
  }
}
