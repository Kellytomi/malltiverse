// cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'cart_provider.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _incrementQuantity(CartProvider cartProvider, Product product) {
    cartProvider.incrementQuantity(product);
  }

  void _decrementQuantity(CartProvider cartProvider, Product product) {
    cartProvider.decrementQuantity(product);
  }

  void _removeItem(CartProvider cartProvider, Product product) {
    cartProvider.removeItemFromCart(product);
  }

  String _formatCurrency(int amount) {
    final formatCurrency = NumberFormat.currency(symbol: '₦', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final totalAmount = cartProvider.cartItems.entries.fold(0, (sum, entry) {
      return sum + int.parse(entry.key.price.replaceAll(RegExp(r'[^0-9]'), '')) * entry.value;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: cartProvider.cartItems.isEmpty
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
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartProvider.cartItems.keys.elementAt(index);
                      final quantity = cartProvider.cartItems[product]!;
                      final int productTotal = int.parse(product.price.replaceAll(RegExp(r'[^0-9]'), '')) * quantity;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          width: 380,
                          height: 138,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFF2A2A2A).withOpacity(0.1),
                              width: 1,
                            ),
                          ),
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
                                            onPressed: () => _removeItem(cartProvider, product),
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
                                                onPressed: () => _decrementQuantity(cartProvider, product),
                                              ),
                                              Text('$quantity', style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () => _incrementQuantity(cartProvider, product),
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
          if (!cartProvider.cartItems.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                width: 380,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED).withOpacity(0.67),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xFF2A2A2A).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
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
            ),
        ],
      ),
    );
  }
}
