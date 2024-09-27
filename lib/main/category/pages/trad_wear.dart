import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/category/widgets/top_navigation_bar.dart';
import 'package:piloolo/main/home/widgets/displays_items.dart'; // Import the custom top navigation bar

class TradWearPage extends StatefulWidget {
  const TradWearPage({super.key});

  @override
  WomenPageState createState() => WomenPageState();
}

class WomenPageState extends State<TradWearPage> {
  final String _selectedCategory = 'All';

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
      body: Column(
        children: [
          const TopNavigationBar(
            selectedIndex: 3, // 2 is for 'Women'
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
                      _selectedCategory,
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
                                imagePath: 'images/salesimages/Niiblue.jpg',
                                title: 'SHEIN Clasi Floral Print Puff Sleeve Belted Dress',
                                price: '\$20.00',
                                imageHeight: 250,
                              );
                            case 1:
                              return const ProductCard(
                                imagePath: 'images/salesimages/Naablue.jpg',
                                title: 'EMERY ROSE Womens Casual Floral Long Sleeve',
                                price: '\$24.00',
                                imageHeight: 250,
                              );
                            case 2:
                              return const ProductCard(
                                imagePath: 'images/salesimages/Niikaft.jpg',
                                title: 'SHEIN Essnce Long Sleeve Sweater',
                                price: '\$32.00',
                                imageHeight: 250,
                              );
                            case 3:
                              return const ProductCard(
                                imagePath: 'images/salesimages/Naagreen.jpg',
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
