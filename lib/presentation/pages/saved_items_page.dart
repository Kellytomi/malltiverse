import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../data/providers/saved_items_provider.dart';
import '../../data/providers/cart_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SavedItemsPage extends StatelessWidget {
  const SavedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final savedItemsProvider = Provider.of<SavedItemsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final savedItems = savedItemsProvider.savedItems;

    final formatter = NumberFormat("#,##0.00", "en_US");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Saved Items',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          final product = savedItems[index];
          final formattedPrice = '₦ ${formatter.format(double.tryParse(product.price.replaceAll('₦', '').replaceAll(',', '')) ?? 0)}';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              width: double.infinity,
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
                    Image.network(product.imagePath, width: 100, height: 100),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(product.description, style: const TextStyle(color: Colors.grey, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, fontSize: 11)),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < product.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.yellow,
                                size: 16,
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          Text(formattedPrice, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.red)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  cartProvider.addItemToCart(product);
                                  Fluttertoast.showToast(
                                    msg: "Product added to your cart",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFFFF7F7D)),
                                ),
                                child: const Text('Add to Cart', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  savedItemsProvider.removeItemFromSaved(product);
                                  Fluttertoast.showToast(
                                    msg: "Product removed from your wishlist",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                },
                                child: const Text('Remove', style: TextStyle(color: Color(0xFFFF7F7D))),
                              ),
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
    );
  }
}
