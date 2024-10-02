import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piloolo/frappe_api_calls/ulr_base.dart'; 
import 'package:logger/logger.dart';

// Initialize the logger
var logger = Logger();

class ApiService {
  // Existing method to fetch products
  Future<List<Product>> fetchProducts() async {
    try {
      var url = Uri.parse('$baseUrl/api/v2/method/piloolo_market.api.call_items.get_items');

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      logger.i('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data') && jsonResponse['data'].containsKey('data')) {
          final List<dynamic> data = jsonResponse['data']['data'];

          logger.i('Parsed product data: $data');

          return data.map((item) => Product.fromJson(item)).toList();
        } else {
          logger.e('Unexpected response format: Missing "data" field');
          throw Exception('Unexpected response format: Missing "data" field');
        }
      } else {
        logger.w('Failed to fetch products. Status code: ${response.statusCode}, Response body: ${response.body}');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      logger.e('Error fetching products', error: e);
      rethrow;
    }
  }

  // Method to filter products based on search query
  Future<List<Product>> filterProducts(String query) async {
    try {
      // Fetch all products
      List<Product> allProducts = await fetchProducts();

      // Filter products that match the search query
      List<Product> filteredProducts = allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return filteredProducts;
    } catch (e) {
      // Log and rethrow error
      logger.e('Error filtering products', error: e);
      rethrow;
    }
  }
}

// Product model to parse JSON data
class Product {
  final String imagePath;
  final String title;
  final String price;

  Product({required this.imagePath, required this.title, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imagePath: json['image'] ?? '', // Path to the product image
      title: json['item_name'] ?? 'No title',
      price: json['price_list_rate']?.toString() ?? '0', // Convert price to string
    );
  }
}
