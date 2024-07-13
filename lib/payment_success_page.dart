import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/check.gif', // Update with your checkmark image path
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Payment Successful',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Thanks for your purchase',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/confetti.gif', // Update with your confetti GIF path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildFloatingNavBar(),
    );
  }

  Widget _buildFloatingNavBar() {
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
      onTap: () {
        // Handle navigation based on index
      },
      child: CircleAvatar(
        backgroundColor: index == 2 ? const Color(0xFFFF7F7D) : Colors.transparent,
        child: Image.asset(
          assetPath,
          color: index == 2 ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
