import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:piloolo/components/currency.dart';
import 'package:http/http.dart' as http;
import 'package:piloolo/frappe_api_calls/ulr_base.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  OrderHistoryPageState createState() => OrderHistoryPageState();
}

class OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('email') ?? ""; // Get email from shared preferences

    // Fetch the order history from the Frappe API
    try {
      final url = Uri.parse('$baseUrl/api/v2/method/piloolo_market.api.order_history.get_user_orders?email=$userEmail');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      // Debug: Print the response
      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          // Correct the path to access the orders
          if (responseData['data']['status'] == 'success') {
            orders = List<Map<String, dynamic>>.from(responseData['data']['orders']);
          }
          isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print('Failed to fetch orders: ${response.statusCode} ${response.body}');
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching order history: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Order History"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty 
              ? const Center(child: Text('No orders found.')) // Display when no orders are found
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: const Color.fromARGB(255, 255, 181, 181), // Set background color here
                      child: ListTile(
                        title: Text('${order['name']}', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white,
                        ),),
                        subtitle: Text('Total: $currencySign${order['total_amount']}', style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailsPage(order: order),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = order['items'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(item['item']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: $currencySign${item['item_price']}'),
                  Text('Size: ${item['item_size']}'),
                  Text('Quantity: ${item['quantity']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
