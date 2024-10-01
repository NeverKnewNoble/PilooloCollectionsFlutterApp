// home.dart
import 'package:flutter/material.dart';
import 'package:piloolo/main/home/widgets/category_items.dart';
import 'package:piloolo/components/displays_items.dart';
import 'package:piloolo/main/home/widgets/image_slider.dart';
import 'package:piloolo/main/home/widgets/search_bar.dart';
import 'package:piloolo/components/pagebar.dart'; 
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/frappe_api_calls/api_service.dart'; // Import the API service

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

           actions: const [
            ShoppingCartAction(), // Use the shopping cart action from the new file
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
                          return ProductCard(
                            imagePath: product.imagePath,
                            title: product.title,
                            price: '\$${product.price}', // Assuming USD currency
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
