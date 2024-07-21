import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'products.dart';
import 'cart_provider.dart';
import 'saved_items_provider.dart';
import 'api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> _futureProducts;
  final String organizationId = '63e89fa612b54ca6be9095ad7293ba28';
  final String appId = 'DUP9EEKYT2KF2J4';
  final String apiKey = 'ce3f9cdf207947a09ef5fcc7e896a3f220240713120004272056';

  @override
  void initState() {
    super.initState();
    _futureProducts = ApiService().fetchProducts(organizationId, appId, apiKey);
  }

  String _titleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: 232,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/featured_product.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FutureBuilder<List<Product>>(
                future: _futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products available'));
                  } else {
                    final productsByCategory = <String, List<Product>>{};
                    for (var product in snapshot.data!) {
                      final category = _titleCase(product.category);
                      if (!productsByCategory.containsKey(category)) {
                        productsByCategory[category] = [];
                      }
                      productsByCategory[category]!.add(product);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: productsByCategory.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(entry.key, style: const TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
                            ),
                            ProductSection(products: entry.value),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  final List<Product> products;

  const ProductSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final savedItemsProvider = Provider.of<SavedItemsProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          final isSaved = savedItemsProvider.isSaved(product);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: product.imagePath.startsWith('http')
                      ? Image.network(product.imagePath, width: 185, height: 184)
                      : Image.asset(product.imagePath, width: 185, height: 184),  // Use asset image if imagePath is local
                ),
                const SizedBox(height: 8),
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
                        Fluttertoast.showToast(
                          msg: "Cart Successfully Updated",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
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
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        color: isSaved ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        if (isSaved) {
                          savedItemsProvider.removeItemFromSaved(product);
                          Fluttertoast.showToast(
                            msg: "Removed from wishlist",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                        } else {
                          savedItemsProvider.addItemToSaved(product);
                          Fluttertoast.showToast(
                            msg: "Added to wishlist",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
