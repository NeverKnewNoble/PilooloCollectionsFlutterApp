import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/category/widgets/top_navigation_bar.dart'; // Import the custom top navigation bar

class WomenPage extends StatefulWidget {
  const WomenPage({super.key});

  @override
  WomenPageState createState() => WomenPageState();
}

class WomenPageState extends State<WomenPage> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 1, // Category index for the bottom navigation
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        actions: const [
          ShoppingCartAction(), // Use the shopping cart action from the new file
        ],
      ),
      backgroundColor: Colors.white,
      body: const Column(
        children: [
          TopNavigationBar(
            selectedIndex: 2, // 2 is for 'Women'
          ),
          Expanded(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Women Page',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text('This is the Women Category Page'),
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
