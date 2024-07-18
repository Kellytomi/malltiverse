import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'checkout_page.dart';
import 'payment_page.dart';
import 'payment_success_page.dart';
import 'custom_nav_bar.dart';

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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MainPage(selectedIndex: 0),
        '/cart': (context) => const MainPage(selectedIndex: 1),
        '/checkout': (context) => const MainPage(selectedIndex: 2),
        '/payment': (context) => const PaymentPage(),
        '/payment_success': (context) => const PaymentSuccessPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final int selectedIndex;

  const MainPage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;
  late PageController _pageController;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const CheckoutPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
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
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          _selectedIndex == 0
              ? 'Product List'
              : (_selectedIndex == 1 ? 'My Cart' : 'Checkout'),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leadingWidth: 60,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
