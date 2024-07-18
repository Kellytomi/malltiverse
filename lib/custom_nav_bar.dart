import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

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
          _buildNavBarItem(0, 'assets/icons/home.png'),
          _buildNavBarItem(1, 'assets/icons/cart1.png'),
          _buildNavBarItem(2, 'assets/icons/checkout1.png'),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(int index, String assetPath) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: CircleAvatar(
        backgroundColor: selectedIndex == index ? const Color(0xFFFF7F7D) : Colors.transparent,
        child: Image.asset(
          assetPath,
          color: selectedIndex == index ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}