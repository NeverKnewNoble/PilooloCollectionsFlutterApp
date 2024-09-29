import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/category/widgets/top_navigation_bar.dart';
import 'package:piloolo/main/category/widgets/women_leftdrawer.dart';
import 'package:piloolo/components/displays_items.dart'; // Import the custom top navigation bar

class WomenPage extends StatefulWidget {
  const WomenPage({super.key});

  @override
  WomenPageState createState() => WomenPageState();
}

class WomenPageState extends State<WomenPage> {
  String _selectedCategory = 'All'; // Changed to mutable state

  void _handleCategoryTap(String category) {
    setState(() {
      _selectedCategory = category; // Update the selected category
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 1, // Category index for the bottom navigation
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black), // Add a menu icon
              onPressed: () {
                // Open the drawer
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: const [
          ShoppingCartAction(), // Use the shopping cart action from the new file
        ],
      ),
      backgroundColor: Colors.white,
      drawer: WomenLeftDrawer(
        onCategoryTap: _handleCategoryTap, // Pass the callback to the drawer
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
        children: [
          const TopNavigationBar(
            selectedIndex: 2, // 2 is for 'Women'
          ),
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Align the category text to the top-left
                    Text(
                      _selectedCategory, // Display the current selected category
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 147, 147),
                      ),
                    ),
                    // Add some spacing between the text and grid
                    const SizedBox(height: 20),
                    // Grid of Products
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: 4, // Update item count as necessary
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return const ProductCard(
                                imagePath: 'images/salesimages/skirtfront.jpeg',
                                title: 'SHEIN Clasi Floral Print Puff Sleeve Belted Dress',
                                price: '\$20.00',
                                imageHeight: 250,
                              );
                            case 1:
                              return const ProductCard(
                                imagePath: 'images/salesimages/flowfront.jpeg',
                                title: 'EMERY ROSE Womens Casual Floral Long Sleeve',
                                price: '\$24.00',
                                imageHeight: 250, 
                              );
                            case 2:
                              return const ProductCard(
                                imagePath: 'images/salesimages/sweatfront.jpeg',
                                title: 'SHEIN Essnce Long Sleeve Sweater',
                                price: '\$32.00',
                                imageHeight: 250,
                              );
                            case 3:
                              return const ProductCard(
                                imagePath: 'images/salesimages/jacketfront.jpeg',
                                title: 'SHEIN WOMANS Stylish Jacket',
                                price: '\$22.00',
                                imageHeight: 250,
                              );
                            default:
                              return const SizedBox();
                          }
                        },
                      ),
                    ),
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
