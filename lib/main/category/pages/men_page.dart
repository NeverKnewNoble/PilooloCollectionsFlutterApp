import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/category/widgets/men_leftdrawer.dart';
import 'package:piloolo/main/category/widgets/top_navigation_bar.dart';
import 'package:piloolo/components/displays_items.dart'; 
import 'package:piloolo/frappe_api_calls/all_men_cloth.dart';
import 'package:piloolo/frappe_api_calls/ulr_base.dart'; 
import 'package:piloolo/components/currency.dart';
import 'package:shimmer/shimmer.dart';  // Import shimmer package

class MenPage extends StatefulWidget {
  const MenPage({super.key});

  @override
  MenPageState createState() => MenPageState();
}

class MenPageState extends State<MenPage> {
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
      drawer: MenLeftDrawer(
        onCategoryTap: _handleCategoryTap, // Handle category changes
        onPriceRangeChanged: _handlePriceRangeChange, // Handle price range changes
      ),
      body: Column(
        children: [
          const TopNavigationBar(
            selectedIndex: 0, // 1 is for 'Men'
          ),
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedCategory, // Display the current selected category
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 147, 147),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Grid of Products
                    Expanded(
                      child: FutureBuilder<List<Product>>(
                        future: futureProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return _buildShimmerGrid();  // Show shimmer while loading
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No items yet'));
                          } else {
                            final products = snapshot.data!;

                            final filteredProducts = products.where((product) {
                              final price = double.tryParse(product.price.toString()) ?? 0.0;
                              final matchesCategory = _selectedCategory == 'All' || product.customMenCategory == _selectedCategory;
                              final matchesPrice = price >= _minPrice && price <= _maxPrice;
                              return matchesCategory && matchesPrice;
                            }).toList();

                            if (filteredProducts.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No items yet for now',
                                  style: TextStyle(fontSize: 18),
                                ),
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
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = filteredProducts[index];
                                final priceInDouble = double.tryParse(product.price.toString()) ?? 0.0;
                                final fullImageUrl = product.imagePath.startsWith('http')
                                    ? product.imagePath
                                    : '$baseUrl${product.imagePath}';

                                return FutureBuilder<String>(
                                  future: _convertPrice(priceInDouble),
                                  builder: (context, priceSnapshot) {
                                    String priceText = 'Loading...';

                                    if (priceSnapshot.connectionState == ConnectionState.done && priceSnapshot.hasData) {
                                      priceText = '$currencySign${priceSnapshot.data}';
                                    }

                                    return ProductCard(
                                      imagePath: fullImageUrl,
                                      title: product.title,
                                      price: priceText,
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
