import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piloolo/components/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:piloolo/frappe_api_calls/ulr_base.dart'; 
import 'package:piloolo/main/cart/widget/cart_provider.dart';

class OrderService {
  Future<void> createOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Retrieve shipping address and user info from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('user') ?? ""; // Replace with user logic if necessary
    String firstName = prefs.getString('first_name') ?? '';
    String lastName = prefs.getString('last_name') ?? '';
    String location = prefs.getString('location') ?? 'Ghana';
    String city = prefs.getString('city') ?? '';
    String phoneNumber = prefs.getString('phone_number') ?? '';
    String stateProvince = prefs.getString('stateprovidence_optional') ?? '';
    String postZipCode = prefs.getString('postzip_code') ?? '';
    String addressLine1 = prefs.getString('address_line_1') ?? '';
    String addressLine2 = prefs.getString('address_line_2_optional') ?? '';
    String email = prefs.getString('email') ?? '';
  
 
    // Retrieve total amount and shipping fee (can also be calculated here)
    double totalAmount = cartProvider.totalPrice(); // Replace with actual total amount if calculated elsewhere
    double shippingFee = 0; // Replace with your actual shipping fee logic

    // Retrieve cart items
    List<Map<String, String>> items = cartProvider.cart.map((item) {
      return {
        'item': item.title,
        'item_price': item.price.toString(),
        'item_size': item.size,
        'item_quantity': item.quantity.toString(),
      };
    }).toList();

    // Construct order data
    final Map<String, dynamic> orderData = {
      'order_data': {
        'user': userEmail,
        'total_amount': totalAmount,
        'shipping_fee': shippingFee,
        'usr_first_name': firstName,
        'usr_last_name': lastName,
        'location': location,
        'city': city,
        'phone_number': phoneNumber,
        'stateprovidence_option': stateProvince,
        'postzip_code': postZipCode,
        'address_line_1': addressLine1,
        'address_line_2_optional': addressLine2,
        'email': email,
        'currency': currency,
        'items': items,
      },
    };

    // Make API POST request
    try {
      final url = Uri.parse('$baseUrl/api/v2/method/piloolo_market.api.order_api.create_order');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token 0410b41c8b97cbd:4608500208ab280',
        },
        body: json.encode(orderData),
      );

      if (response.statusCode == 200) {
        // Handle successful order creation
        if (kDebugMode) {
          print('Order created successfully: ${response.body}');
        }
      } else {
        // Handle error response
        if (kDebugMode) {
          print('Failed to create order: ${response.statusCode} ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating order: $e');
      }
    }
  }
}
