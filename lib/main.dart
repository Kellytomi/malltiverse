import 'package:flutter/material.dart';
import 'home_page.dart' as home;
import 'cart_page.dart' as cart;
import 'checkout_page.dart' as checkout;
import 'payment_page.dart' as payment;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const home.HomePage(),
    const cart.CartPage(),
    const checkout.CheckoutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: Image.asset(
            'assets/icons/Malltiverse.png',
            width: 40, // Adjust the width as needed
            height: 40, // Adjust the height as needed
          ), // Add your logo here
        ),
        title: Text(
          _selectedIndex == 0 ? 'Product List' : (_selectedIndex == 1 ? 'My Cart' : 'Checkout'),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leadingWidth: 60, // Adjust the leading width to control spacing
      ),
      body: _pages[_selectedIndex],
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
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        backgroundColor: _selectedIndex == index ? const Color(0xFFFF7F7D) : Colors.transparent,
        child: Image.asset(
          assetPath,
          color: _selectedIndex == index ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
