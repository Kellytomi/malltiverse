import 'package:flutter/material.dart';
import 'saved_items_page.dart';
import 'order_history_page.dart'; // Import the OrderHistoryPage

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFF2A2A2A),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Etoma-etoto',
                        style: TextStyle(
                          color: Color(0xFFFF7F7D),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'kelvinetoma95@gmail.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Malltiverse credit balance ₦ 0'),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('MY MALLTIVERSE ACCOUNT', style: TextStyle(fontSize: 14, fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
            ),
            const ListTile(
              leading: Icon(Icons.star),
              title: Text('Ratings & Reviews'),
            ),
            const ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('Vouchers'),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Saved Items'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavedItemsPage()),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.store),
              title: Text('Followed Sellers'),
            ),
            const ListTile(
              leading: Icon(Icons.visibility),
              title: Text('Recently Viewed'),
            ),
            const ListTile(
              leading: Icon(Icons.search),
              title: Text('Recently Searched'),
            ),
          ],
        ),
      ),
    );
  }
}
