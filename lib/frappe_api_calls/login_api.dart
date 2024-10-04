import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piloolo/frappe_api_calls/ulr_base.dart';

// Function to verify login credentials using the Frappe API
Future<Map<String, dynamic>> verifyLogin(String email, String password) async {
  final url = Uri.parse('$baseUrl/api/v2/method/piloolo_market.api.login.verify_login');
  final response = await http.post(
    url, // Use `url` directly without casting
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'username': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    // Check if the login was successful
    if (responseData['data']['status'] == 'success') {
      return {
        'status': responseData['data']['status'],
        'message': responseData['data']['message'],
      };
    } else {
      // Handle login failure
      return {
        'status': responseData['data']['status'],
        'message': responseData['data']['message'],
      };
    }
  } else {
    throw Exception('Failed to log in');
  }
}
