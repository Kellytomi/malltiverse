import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/cart_page.dart';
import 'presentation/pages/checkout_page.dart';
import 'presentation/pages/payment_page.dart';
import 'presentation/pages/payment_success_page.dart';
import 'presentation/widgets/custom_nav_bar.dart';
import 'data/providers/cart_provider.dart';
import 'presentation/pages/profile_page.dart';
import 'data/providers/saved_items_provider.dart';
import 'data/providers/order_history_provider.dart';
import 'core/connectivity_provider.dart';
import 'core/connectivity_listener.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SavedItemsProvider()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => OrderHistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConnectivityListener(
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        '/profile': (context) => const MainPage(selectedIndex: 3),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final int selectedIndex;

  const MainPage({super.key, required this.selectedIndex});

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
    const ProfilePage(),
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
    int cartItemCount = Provider.of<CartProvider>(context).totalItems;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0),
          child: Image.asset(
            'assets/icons/Malltiverse.png',
            width: 99,  // Updated width
            height: 31, // Updated height
          ),
        ),
        title: Text(
          _selectedIndex == 0
              ? 'Product List'
              : (_selectedIndex == 1
                  ? 'My Cart'
                  : (_selectedIndex == 2 ? 'Checkout' : 'Profile')),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leadingWidth: 125,  // Adjusted leading width to accommodate the new size
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
        cartItemCount: cartItemCount,
      ),
    );
  }
}
