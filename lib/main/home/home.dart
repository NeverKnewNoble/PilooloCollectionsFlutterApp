import 'package:flutter/material.dart';
import 'package:piloolo/main/home/widgets/category_items.dart';
import 'package:piloolo/components/displays_items.dart';
import 'package:piloolo/main/home/widgets/image_slider.dart';
import 'package:piloolo/main/home/widgets/search_bar.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/frappe_api_calls/api_service.dart';
import 'package:piloolo/components/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart'; // Shimmer package

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentSlide = 0;
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
    _loadCurrency(); // Load the updated currency when HomePage loads
  }

  Future<void> _loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currency = prefs.getString('currency') ?? 'USD'; // Default to USD if not set
      currencySign = getCurrencySign(currency);
    });
  }

  Future<String> _convertPrice(double priceInUSD) async {
    // Call the function to get the converted price based on the selected currency
    return await calculatePrice(priceInUSD, currency);
  }

  // Function to build the shimmer loading effect for a grid
  Widget _buildShimmerLoadingGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.6,
      ),
      itemCount: 6, // Number of shimmer items to display
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

  // Function to handle errors and show a retry button
  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('Something went wrong', style: TextStyle(fontSize: 18, color: Colors.red)),
          const SizedBox(height: 8),
          Text(errorMessage, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                futureProducts = ApiService().fetchProducts(); // Retry fetching products
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // Function to display when no products are found
  Widget _buildNoProductsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.info_outline, size: 48, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0, // HomePage index for the bottom navigation
      body: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false, // Removes the back arrow
          actions: [
            // Currency Display (Non-editable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    currency, // Display the global currency variable
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const ShoppingCartAction(), // Use the shopping cart action from the new file
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: MySearchBAR(),
              ),
              const SizedBox(height: 16.0),

              // Image Slider
              ImageSlider(
                currentSlide: _currentSlide,
                totalSlides: 3, // Total number of slides
                onChange: (int newSlide) {
                  setState(() {
                    _currentSlide = newSlide; // Update the current slide
                  });
                },
              ),

              const SizedBox(height: 16.0),

              // Categories Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Horizontal scrolling for categories
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryItem(
                      imagePath: 'images/salesimages/real pic/1721025213a33f67ae5f77d58e2987c90821a7c102_thumbnail_405x552.jpeg',
                      title: 'Hoodies',
                    ),
                    CategoryItem(
                      imagePath: 'images/salesimages/real pic/shirt.jpg',
                      title: 'Shirt',
                    ),
                    CategoryItem(
                      imagePath: 'images/salesimages/real pic/1721981555d2c254458f75b4b2c77a934e51f60b18_thumbnail_405x552.jpeg',
                      title: 'T-Shirts',
                    ),
                    CategoryItem(
                      imagePath: 'images/salesimages/real pic/carttrousers.jpg',
                      title: 'Trousers',
                    ),
                    CategoryItem(
                      imagePath: 'images/salesimages/real pic/cat-office.jpg',
                      title: 'Suit | Coat',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Divider
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 370,
                  child: Divider(
                    color: Colors.black.withOpacity(0.3), // Faint line
                    thickness: 1,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'What\'s New!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 147, 147)),
                ),
              ),

              // Grid of Products fetched from API
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: FutureBuilder<List<Product>>(
                  future: futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show shimmer effect during loading
                      return _buildShimmerLoadingGrid();
                    } else if (snapshot.hasError) {
                      // Show error UI with retry button
                      return _buildErrorWidget(snapshot.error.toString());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Show "no products found" UI
                      return _buildNoProductsFound();
                    } else {
                      // Display the list of products
                      final products = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: products.length, // Use length of fetched products
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final priceInDouble = double.tryParse(product.price.toString()) ?? 0.0; // Convert price to double

                          return FutureBuilder<String>(
                            future: _convertPrice(priceInDouble), // Convert the price
                            builder: (context, snapshot) {
                              String priceText = 'Loading...'; // Placeholder for price

                              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                priceText = '$currencySign${snapshot.data}'; // Update with the converted price
                              }

                              // Display product details with either "Loading..." or the converted price
                              return ProductCard(
                                imagePath: product.imagePath,
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
    );
  }
}
