// cart_page.dart
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  static final Map<Product, int> _cartItems = {};

  const CartPage({super.key});

  static void addItemToCart(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
  }

  static Map<Product, int> get cartItems => _cartItems;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _incrementQuantity(Product product) {
    setState(() {
      CartPage._cartItems[product] = CartPage._cartItems[product]! + 1;
    });
  }

  void _decrementQuantity(Product product) {
    setState(() {
      if (CartPage._cartItems[product] == 1) {
        CartPage._cartItems.remove(product);
      } else {
        CartPage._cartItems[product] = CartPage._cartItems[product]! - 1;
      }
    });
  }

  void _removeItem(Product product) {
    setState(() {
      CartPage._cartItems.remove(product);
    });
  }

  String _formatCurrency(int amount) {
    final formatCurrency = NumberFormat.currency(symbol: '₦', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = CartPage._cartItems.entries.fold(0, (sum, entry) {
      return sum + int.parse(entry.key.price.replaceAll(RegExp(r'[^0-9]'), '')) * entry.value;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: CartPage._cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'No Item in Cart',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: CartPage._cartItems.length,
                    itemBuilder: (context, index) {
                      final product = CartPage._cartItems.keys.elementAt(index);
                      final quantity = CartPage._cartItems[product]!;
                      final int productTotal = int.parse(product.price.replaceAll(RegExp(r'[^0-9]'), '')) * quantity;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(product.imagePath, width: 60, height: 60, fit: BoxFit.contain),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(product.name, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 12)),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () => _removeItem(product),
                                          ),
                                        ],
                                      ),
                                      Text(product.description, style: const TextStyle(color: Colors.grey, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, fontSize: 11)),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () => _decrementQuantity(product),
                                              ),
                                              Text('$quantity', style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () => _incrementQuantity(product),
                                              ),
                                            ],
                                          ),
                                          Text(_formatCurrency(productTotal), style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Shopping Summary', style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sub-Total', style: TextStyle(fontSize: 12, fontFamily: 'Montserrat')),
                    Text(_formatCurrency(totalAmount), style: const TextStyle(fontSize: 12, fontFamily: 'Montserrat')),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Fee', style: TextStyle(fontSize: 12, fontFamily: 'Montserrat')),
                    Text('₦1,500', style: TextStyle(fontSize: 12, fontFamily: 'Montserrat')),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount Amount', style: TextStyle(fontSize: 12, fontFamily: 'Montserrat')),
                    Text('₦3,500', style: TextStyle(fontSize: 12, fontFamily: 'Montserrat')),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
                    Text(_formatCurrency(totalAmount + 1500 - 3500), style: const TextStyle(fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF44336),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(306, 44), // Added size
                  ),
                  child: const Text('Checkout', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
