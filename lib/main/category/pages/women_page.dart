import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/category/widgets/top_navigation_bar.dart';
import 'package:piloolo/main/category/widgets/women_leftdrawer.dart';
import 'package:piloolo/components/displays_items.dart'; 
import 'package:piloolo/frappe_api_calls/all_women_cloth.dart';
import 'package:piloolo/frappe_api_calls/ulr_base.dart';
import 'package:piloolo/components/currency.dart';
import 'package:shimmer/shimmer.dart';  // Import shimmer package

class WomenPage extends StatefulWidget {
  const WomenPage({super.key});

  @override
  WomenPageState createState() => WomenPageState();
}

class WomenPageState extends State<WomenPage> {
  String _selectedCategory = 'All';
  double _minPrice = 0;
  double _maxPrice = 1000;

  void _handleCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _handlePriceRangeChange(double minPrice, double maxPrice) {
    setState(() {
      _minPrice = minPrice;
      _maxPrice = maxPrice;
    });
  }

  Future<String> _convertPrice(double priceInUSD) async {
    return await calculatePrice(priceInUSD, currency);
  }

  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  // Function to display shimmer loading effect
  Widget _buildShimmerGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.6,
      ),
      itemCount: 6, // Show 6 shimmer items
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 200,
            width: 150,
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 1, // Index for bottom navigation
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: const [
          ShoppingCartAction(), // Shopping cart icon
        ],
      ),
      backgroundColor: Colors.white,
      drawer: WomenLeftDrawer(
        onCategoryTap: _handleCategoryTap, // Pass category tap callback to the drawer
        onPriceRangeChanged: _handlePriceRangeChange, // Handle price range changes
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopNavigationBar(
            selectedIndex: 1, // 2 is for 'Women'
          ),
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            return _buildShimmerGrid();  // Show shimmer while loading
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No products found'));
                          } else {
                            final products = snapshot.data!.where((product) {
                              final price = double.tryParse(product.price) ?? 0.0;
                              final matchesCategory = _selectedCategory == 'All' || product.customCategory == _selectedCategory;
                              final matchesPrice = price >= _minPrice && price <= _maxPrice;
                              return matchesCategory && matchesPrice;
                            }).toList();

                            if (products.isEmpty) {
                              return const Center(
                                child: Text('No items yet for now'),
                              );
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 0.6,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                final priceInDouble = double.tryParse(product.price) ?? 0.0;
                                final fullImageUrl = product.imagePath.startsWith('http')
                                    ? product.imagePath
                                    : '$baseUrl${product.imagePath}';

                                return FutureBuilder<String>(
                                  future: _convertPrice(priceInDouble),
                                  builder: (context, priceSnapshot) {
                                    String priceText = 'Loading...'; // Placeholder for price

                                    if (priceSnapshot.connectionState == ConnectionState.done && priceSnapshot.hasData) {
                                      priceText = '$currencySign${priceSnapshot.data}'; // Update with the converted price
                                    }

                                    return ProductCard(
                                      imagePath: fullImageUrl,
                                      title: product.title,
                                      price: priceText, // Show converted price or placeholder
                                    );
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
