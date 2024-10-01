import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/components/displays_items.dart';
import 'widgets/top_navigation_bar.dart';
import 'package:piloolo/frappe_api_calls/api_service.dart'; 
import 'package:piloolo/frappe_api_calls/ulr_base.dart';
import 'package:piloolo/components/currency.dart';

class CategoryGenderPage extends StatefulWidget {
  const CategoryGenderPage({super.key});

  @override
  CategoryGenderPageState createState() => CategoryGenderPageState();
}

class CategoryGenderPageState extends State<CategoryGenderPage> {
  final String _selectedCategory = 'All';
  late Future<List<Product>> futureProducts; // Declare the future for products

  @override
  void initState() {
    super.initState();
    // Initialize futureProducts to fetch products
    futureProducts = ApiService().fetchProducts();
  }

  Future<String> _convertPrice(double priceInUSD) async {
    return await calculatePrice(priceInUSD, currency);
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
            selectedIndex: 0, // 0 is for 'All'
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
                    const SizedBox(height: 20),
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
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                final priceInDouble = double.tryParse(product.price.toString()) ?? 0.0;

                                return FutureBuilder<String>(
                                  future: _convertPrice(priceInDouble),
                                  builder: (context, priceSnapshot) {
                                    if (priceSnapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (priceSnapshot.hasError) {
                                      return Text('Error: ${priceSnapshot.error}');
                                    } else {
                                      return ProductCard(
                                        imagePath: product.imagePath.startsWith('http')
                                            ? product.imagePath
                                            : '$baseUrl${product.imagePath}',
                                        title: product.title,
                                        price: '$currencySign${priceSnapshot.data}',
                                      );
                                    }
                                  },
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
