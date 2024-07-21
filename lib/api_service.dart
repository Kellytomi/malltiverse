import 'dart:convert';
import 'package:http/http.dart' as http;
import 'products.dart';

class ApiService {
  final String _baseUrl = 'https://api.timbu.cloud/products';

  Future<List<Product>> fetchProducts(String organizationId, String appId, String apiKey, {int page = 1, int size = 10, bool reverseSort = false}) async {
    final Uri uri = Uri.parse('$_baseUrl?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey');
    
    
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('items') && jsonResponse['items'] != null) {
        List<dynamic> items = jsonResponse['items'];
        try {
          return items.map((item) => Product.fromJson(item)).toList();
        } catch (e) {
          throw Exception('Error parsing products');
        }
      } else {
        throw Exception('No data found');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product?> fetchProductById(String productId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$productId'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.isNotEmpty) {
        return Product.fromJson(jsonResponse);
      }
    }
    return null;
  }

  Future<void> updateProductQuantity(String productId, int newQuantity, String appId, String apiKey) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/$productId'),
      headers: {
        'Content-Type': 'application/json',
        'Appid': appId,
        'Apikey': apiKey,
      },
      body: json.encode({'available_quantity': newQuantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product quantity');
    }
  }
}
