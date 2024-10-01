import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Frappe API configuration
const String frappeURL = 'http://127.0.0.1:8001/api/v2/method/piloolo_market.api.address.create_user_address';
const String apiKey = '7a1af17f988142b'; 
const String apiToken = 'dd350f0e350c332';

// Function to create a new "User Address Info" document via custom API endpoint
Future<void> createUserAddressInfo(Map<String, dynamic> data) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'token $apiKey:$apiToken',
  };

  // Make the POST request to create a new document
  final response = await http.post(
    Uri.parse(frappeURL),
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    if (kDebugMode) {
      print('Document created successfully: ${response.body}');
    }
  } else {
    if (kDebugMode) {
      print('Failed to create document: ${response.body}');
    }
    throw Exception('Failed to create document');
  }
}

// Function to update an existing "User Address Info" document
Future<void> updateUserAddressInfo(String docName, Map<String, dynamic> data) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'token $apiKey:$apiToken',
  };

  // Make the PUT request to update the document
  final response = await http.put(
    Uri.parse('$frappeURL/$docName'),
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    if (kDebugMode) {
      print('Document updated successfully');
    }
  } else {
    if (kDebugMode) {
      print('Failed to update document: ${response.body}');
    }
    throw Exception('Failed to update document');
  }
}
