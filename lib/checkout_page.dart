import 'package:flutter/material.dart';
import 'payment_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedPickupIndex = 1;

  void _onPickupOptionChanged(int? value) {
    setState(() {
      _selectedPickupIndex = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select how to receive your package(s)',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pickup',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _buildPickupOption(
            'Old Secretariat Complex, Area 1, Garki, Abaji Abji',
            1,
          ),
          _buildPickupOption(
            'Sokoto Street, Area 1, Garki, Area 1 AMAC',
            2,
          ),
          const SizedBox(height: 16),
          const Text(
            'Delivery',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: 'Enter your delivery address',
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Contact',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 248,
            height: 38.83,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: 'Phone nos 1',
              ),
            ),
          ),
          const SizedBox(height: 16), // More space between contact fields
          SizedBox(
            width: 248,
            height: 38.83,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: 'Phone nos 2',
              ),
            ),
          ),
          const SizedBox(height: 55), // More space before the button
          Center(
            child: SizedBox(
              width: 307, // Set the desired width for the button
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7F7D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Go to Payment',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickupOption(String address, int value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
      title: Text(
        address,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Montserrat',
        ),
      ),
      leading: Radio<int>(
        value: value,
        groupValue: _selectedPickupIndex,
        activeColor: const Color(0xFFF44336),
        onChanged: _onPickupOptionChanged,
      ),
    );
  }
}
