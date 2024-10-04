import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:piloolo/frappe_api_calls/ulr_base.dart';

class SignUpService {
  Future<Map<String, dynamic>> signUp(String email, String firstName, String password) async {
    final url = Uri.parse('$baseUrl/api/v2/method/piloolo_market.api.user_api.sign_up');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'first_name': firstName,
        'password': password,
      }),
    );

    // Log the response body for debugging
    if (kDebugMode) {
      print('API Raw Response: ${response.body}');
    }

    try {
      // Decode the response and extract 'data'
      final responseData = json.decode(response.body);
      final data = responseData['data']; // Extract data key

      // Print response data for better debugging
      if (kDebugMode) {
        print('API Parsed Response: $data');
      }

      // Check if status is 'success'
      if (data['status'] == 'success') {
        return {
          'status': 'success',
          'message': data['message'],
        };
      } else {
        return {
          'status': 'fail',
          'message': data['message'] ?? 'Sign Up Completed, Please try to login',
        };
      }
    } catch (e) {
      // Handle JSON parsing error
      if (kDebugMode) {
        print('Error parsing response: $e');
      }
      return {
        'status': 'fail',
        'message': 'An error occurred while parsing the response',
      };
    }
  }
}
