import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'widgets/top_navigation_bar.dart'; // Import the custom top navigation bar

class CategoryGenderPage extends StatefulWidget {
  const CategoryGenderPage({super.key});

  @override
  CategoryGenderPageState createState() => CategoryGenderPageState();
}

class CategoryGenderPageState extends State<CategoryGenderPage> {
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
      body: const Column(
        children: [
          TopNavigationBar(
            selectedIndex: 0, // 0 is for 'All'
          ),
          Expanded(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'All Category Page',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text('This is the default page for All Categories'),
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
