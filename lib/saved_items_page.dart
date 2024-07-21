import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'saved_items_provider.dart';
import 'cart_provider.dart';
import 'products.dart';

class SavedItemsPage extends StatelessWidget {
  const SavedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final savedItemsProvider = Provider.of<SavedItemsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final savedItems = savedItemsProvider.savedItems;

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
      backgroundColor: Colors.white, // Set the background color to white
      body: ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          final product = savedItems[index];
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
                    Image.asset(product.imagePath, width: 100, height: 100),
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
                          Text(product.price, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: Colors.red)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  cartProvider.addItemToCart(product);
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
