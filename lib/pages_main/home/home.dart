import 'package:flutter/material.dart';
import 'package:piloolo/pages_main/home/widgets/category_items.dart';
import 'package:piloolo/pages_main/home/widgets/displays_items.dart';
import 'package:piloolo/pages_main/home/widgets/image_slider.dart';
import 'package:piloolo/pages_main/home/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
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

            // ImageSlider
            ImageSlider(
              currentSlide: 0,
              onChange: (int newSlide) {
                setState(() {
                  // Handle slide change
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

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryItem(
                    imagePath: 'images/salesimages/real pic/1714102778d58511b91a3cfea3e0d966fcd73335be_thumbnail_288x.jpeg',
                    title: 'Jackets',
                  ),
                  CategoryItem(
                    imagePath: 'images/salesimages/real pic/1721025213a33f67ae5f77d58e2987c90821a7c102_thumbnail_405x552.jpeg',
                    title: 'Hoodies',
                  ),
                  CategoryItem(
                    imagePath: 'images/salesimages/real pic/1721981555d2c254458f75b4b2c77a934e51f60b18_thumbnail_405x552.jpeg',
                    title: 'T-Shirts',
                  ),
                  CategoryItem(
                    imagePath: 'images/salesimages/real pic/1696435347e62fcbdf4fd5c9d5c86048c071bf8c92_thumbnail_405x552.jpeg',
                    title: 'Pants',
                  ),
                  CategoryItem(
                    imagePath: 'images/salesimages/real pic/20326334_50383775_2048.jpg',
                    title: 'Hats',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
              width: 370, // Set your desired width
              child: Divider(
                color: Colors.black.withOpacity(0.3), // Faint line
                thickness: 1, // Adjust thickness as needed
              ),
            ),
            ),
            
            // GridView with dynamic content height
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: GridView.builder(
                shrinkWrap: true, // Allows it to take only the necessary space
                physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items in a row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.6, // Adjust for better fit
                ),
                itemCount: 6, // Update item count based on your items
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const ProductCard(
                        imagePath: 'images/salesimages/skirtfront.jpeg',
                        title: 'SHEIN Clasi Floral Print Puff Sleeve Belted Dress',
                        price: '\$20.00',
                        imageHeight: 250, // Updated image height
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
                    case 4:
                      return const ProductCard(
                        imagePath: 'images/salesimages/menblue.jpeg',
                        title: 'Mens Blue Collar Shirt',
                        price: '\$22.99',
                        imageHeight: 250,
                      );
                    case 5:
                      return const ProductCard(
                        imagePath: 'images/salesimages/mengreen.jpeg',
                        title: 'Mens Green Collar Shirt',
                        price: '\$22.99',
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Me'),
        ],
        selectedItemColor: const Color(0xFFFF0000),
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
