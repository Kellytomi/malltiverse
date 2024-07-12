import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Item in Cart',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
