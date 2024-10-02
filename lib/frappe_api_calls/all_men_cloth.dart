import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piloolo/frappe_api_calls/ulr_base.dart'; 
import 'package:logger/logger.dart';

// Initialize the logger
var logger = Logger();

class ApiService {
  Future<List<Product>> fetchProducts() async {
    try {
      // Define the API endpoint
      var url = Uri.parse('$baseUrl/api/v2/method/piloolo_market.api.call_man_cloths.male_items');

      // Send a GET request
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Log the response body for debugging
      logger.i('Response body: ${response.body}');

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if the response contains the 'data' field and parse it
        if (jsonResponse.containsKey('data') && jsonResponse['data'].containsKey('data')) {
          final List<dynamic> data = jsonResponse['data']['data']; // Extract the nested list
          
          // Log the parsed data for debugging
          logger.i('Parsed product data: $data');

          // Map JSON to a list of Product instances
          return data.map((item) => Product.fromJson(item)).toList();
        } else {
          logger.e('Unexpected response format: Missing "data" field');
          throw Exception('Unexpected response format: Missing "data" field');
        }
      } else {
        // Log and throw error for failed response
        logger.w('Failed to fetch products. Status code: ${response.statusCode}, Response body: ${response.body}');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      logger.e('Error fetching products', error: e);
      rethrow; // Rethrow the error for further handling in the app
    }
  }
}

// Product model to parse JSON data
class Product {
  final String imagePath;
  final String title;
  final String price;
  final String customMenCategory; // Add this field

  Product({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.customMenCategory, // Include it in the constructor
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imagePath: json['image'] ?? '', // Path to the product image
      title: json['item_name'] ?? 'No title',
      price: json['price_list_rate']?.toString() ?? '0', // Convert price to string
      customMenCategory: json['custom_men_category'] ?? 'Unknown', // Map 'custom_men_category'
    );
  }
}

