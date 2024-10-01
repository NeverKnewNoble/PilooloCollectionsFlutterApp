import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/category/widgets/top_navigation_bar.dart';
import 'package:piloolo/components/displays_items.dart'; 
import 'package:piloolo/frappe_api_calls/african_cloth.dart';
import 'package:piloolo/frappe_api_calls/ulr_base.dart'; 
import 'package:piloolo/components/currency.dart';


class TradWearPage extends StatefulWidget {
  const TradWearPage({super.key});

  @override
  WomenPageState createState() => WomenPageState();
}

class WomenPageState extends State<TradWearPage> {
  final String _selectedCategory = 'All';

  late Future<List<Product>> futureProducts; // Declare the future for products

  @override
  void initState() {
    super.initState();
    // Initialize futureProducts to fetch products
    futureProducts = ApiService().fetchProducts();
  }

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
                      child: FutureBuilder<List<Product>>(
                        future: futureProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No products found'));
                          } else {
                            // Display the list of products
                            final products = snapshot.data!;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(), // Allow grid to scroll independently
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 0.6,
                              ),
                              itemCount: products.length, // Use length of fetched products
                              itemBuilder: (context, index) {
                                final product = products[index];
                                final fullImageUrl = product.imagePath.startsWith('http')
                                    ? product.imagePath
                                    : '$baseUrl${product.imagePath}';

                                return ProductCard(
                                  imagePath: fullImageUrl, // Ensure full URL for images
                                  title: product.title,
                                  price: '$currencySign${product.price}',
                                );
                              },
                            );
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
