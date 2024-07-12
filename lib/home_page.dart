import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/featured_product.png', // Make sure to add your images in the assets folder
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Product Carousel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imgList
                    .map((item) => Center(
                        child: Image.asset(item, fit: BoxFit.cover)))
                    .toList(),
              ),
            ),
          ),
          // Tech Gadgets Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Tech Gadgets', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ProductSection(
              products: [
                Product(
                  name: 'Joystick Game Controller',
                  description: 'Wired UCOM USB Pad...',
                  price: 'N 11,250',
                  rating: 5,
                  imagePath: 'assets/images/joystick.png',
                ),
                Product(
                  name: 'Apple iPhone 14 Pro',
                  description: '6GB RAM + 128GB ROM',
                  price: 'N 1,450,000',
                  rating: 5,
                  imagePath: 'assets/images/iphone.png',
                ),
                Product(
                    name: 'Touch Screen Smart Watch',
                    description: 'For Andriod & IOS',
                    price: 'N 9,170',
                    rating: 5,
                    imagePath: 'assets/images/watch.png'),
                Product(
                    name: 'Itel Bluetooth Earphones',
                    description: 'BUDS ACE Wireless Earpods',
                    price: 'N 17,660',
                    rating: 4,
                    imagePath: 'assets/images/earbuds.png')
              ],
            ),
          ),
          // Men's Fashion Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Men\'s Fashion', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ProductSection(
              products: [
                Product(
                  name: 'Men\'s Belt Leather',
                  description: 'Buckle Brown Timeless Belt',
                  price: 'N 17,500',
                  rating: 4,
                  imagePath: 'assets/images/belt.png',
                ),
                Product(
                  name: 'Quality Plain Face Cap',
                  description: 'Plain Black Face Cap',
                  price: 'N 4,000',
                  rating: 5,
                  imagePath: 'assets/images/cap.png',
                ),
                 Product(
                  name: 'Men’s Formal Lace Up Shoes',
                  description: 'Italian Brogues Leather Shoe',
                  price: 'N 21,000',
                  rating: 4,
                  imagePath: 'assets/images/shoe.png',
                ),
                Product(
                  name: 'Men’s Short Sleeve ',
                  description: 'Casual Shirt - Black & Brown',
                  price: 'N 25,900',
                  rating: 5,
                  imagePath: 'assets/images/shirt.png',
                ),
              ],
            ),
          ),
          // Women's Fashion Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Women\'s Fashion', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ProductSection(
              products: [
                Product(
                  name: 'Ladies Leather Chic Bag',
                  description: 'Office Trendy Handbag...',
                  price: 'N 20,950',
                  rating: 4,
                  imagePath: 'assets/images/bag.png',
                ),
                Product(
                  name: 'Summer Tie Neck Long Dress',
                  description: 'Purple Free Floral Dress',
                  price: 'N 10,000',
                  rating: 5,
                  imagePath: 'assets/images/dress.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  final List<Product> products;

  const ProductSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
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
                  child: Image.asset(product.imagePath, width: 200, height: 180),
                ),
                const SizedBox(height: 8),
                Text(product.name, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(product.description, style: const TextStyle(color: Colors.grey, fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFF44336)),
                  ),
                  child: const Text('Add to Cart', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String price;
  final int rating;
  final String imagePath;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
  });
}
