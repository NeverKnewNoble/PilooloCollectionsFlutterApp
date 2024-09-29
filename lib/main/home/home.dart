import 'package:flutter/material.dart';
import 'package:piloolo/main/home/widgets/category_items.dart';
import 'package:piloolo/components/displays_items.dart';
import 'package:piloolo/main/home/widgets/image_slider.dart';
import 'package:piloolo/main/home/widgets/search_bar.dart';
import 'package:piloolo/components/pagebar.dart'; 
import 'package:piloolo/components/shopping_cart_action.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentSlide = 0;
  

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
                  'What\s New!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 255, 147, 147)),
                ),
              ),



              // Grid of Products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: 8, // Update item count as necessary
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
                          imagePath: 'images/salesimages/stripedbrown.webp',
                          title: 'Manfinity Homme Men Striped Print Quarter Zip Polo Shirt',
                          price: '\$10.99',
                          imageHeight: 250,
                          
                        );
                      case 2:
                        return const ProductCard(
                          imagePath: 'images/salesimages/flowfront.jpeg',
                          title: 'EMERY ROSE Womens Casual Floral Long Sleeve',
                          price: '\$24.00',
                          imageHeight: 250,
                          
                        );
                      case 3:
                        return const ProductCard(
                          imagePath: 'images/salesimages/stripped blue.webp',
                          title: 'Manfinity Homme Men Striped Print Colorblock Polo Shirt',
                          price: '\$11.00',
                          imageHeight: 250,
                          
                        );
                      case 4:
                        return const ProductCard(
                          imagePath: 'images/salesimages/sweatfront.jpeg',
                          title: 'SHEIN Essnce Long Sleeve Sweater',
                          price: '\$32.00',
                          imageHeight: 250,
                          
                        );
                      case 5:
                        return const ProductCard(
                          imagePath: 'images/salesimages/jacketfront.jpeg',
                          title: 'SHEIN WOMANS Stylish Jacket',
                          price: '\$22.00',
                          imageHeight: 250,
                          
                        );
                      case 6:
                        return const ProductCard(
                          imagePath: 'images/salesimages/menblue.jpeg',
                          title: 'Mens Blue Collar Shirt',
                          price: '\$22.99',
                          imageHeight: 250,
                          
                        );
                      case 7:
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
      ),
    );
  }
}
