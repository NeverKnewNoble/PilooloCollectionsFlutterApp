import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:piloolo/frappe_api_calls/ulr_base.dart';

class ForgotPasswordService {
  Future<Map<String, dynamic>> sendResetEmail(String email) async {
    final url = Uri.parse('$baseUrl/api/v2/method/piloolo_market.api.user_api.send_password_reset');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
      }),
    );

    // Log response details
    if (kDebugMode) {
      print('API Status Code: ${response.statusCode}');
      print('API Raw Response: ${response.body}');
    }

    // Check if the status code is 200 (OK)
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Check for 'success' status in the response
      if (responseData['status'] == 'success') {
        return {
          'status': 'success',
          'message': responseData['message'],
        };
      } else {
        return {
          'status': 'fail',
          'message': responseData['message'] ?? 'Failed to send reset email',
        };
      }
    } else {
      // Return an error message if the status code is not 200
      return {
        'status': 'fail',
        'message': 'An error occurred while sending the reset email. Status Code: ${response.statusCode}',
      };
    }
  }
}
