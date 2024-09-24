import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 2, // Category index for the bottom navigation
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: const Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cart Page',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text('This is the default page for All orders'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
