import 'package:flutter/material.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView( // Ensure the body is scrollable
        child: Expanded( // Wrap the Column with an Expanded widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    CategoryItem(imagePath: 'images/salesimages/real pic/1714102778d58511b91a3cfea3e0d966fcd73335be_thumbnail_288x.jpeg', title: 'Jackets'),
                    CategoryItem(imagePath: 'images/salesimages/real pic/1721025213a33f67ae5f77d58e2987c90821a7c102_thumbnail_405x552.jpeg', title: 'Hoodies'),
                    CategoryItem(imagePath: 'images/salesimages/real pic/1721981555d2c254458f75b4b2c77a934e51f60b18_thumbnail_405x552.jpeg', title: 'T-Shirts'),
                    CategoryItem(imagePath: 'images/salesimages/real pic/1696435347e62fcbdf4fd5c9d5c86048c071bf8c92_thumbnail_405x552.jpeg', title: 'Pants'),
                    CategoryItem(imagePath: 'images/salesimages/real pic/20326334_50383775_2048.jpg', title: 'Hats'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // New Items Section for Women
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Women',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: const [
                  NewItemCard(imagePath: 'images/salesimages/skirtfront.jpeg', title: 'SHEIN Clasi Floral Print Puff Sleeve Belted Dress', price: '\$20'),
                  NewItemCard(imagePath: 'images/salesimages/flowfront.jpeg', title: 'EMERY ROSE Womens Casual Ditsy Floral Long Sleeve', price: '\$24'),
                  NewItemCard(imagePath: 'images/salesimages/sweatfront.jpeg', title: 'SHEIN Essnce Long Sleeve Sweater', price: '\$32'),
                  NewItemCard(imagePath: 'images/salesimages/jacketfront.jpeg', title: 'SHEIN WOMANS Stylish Jacket', price: '\$22'),
                ],
              ),
              const SizedBox(height: 15), // Add space between sections

              // New Items Section for Men
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Men',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: const [
                  NewItemCard(imagePath: 'images/salesimages/menblue.jpeg', title: 'Mens Blue Collar Shirt', price: '\$22'),
                  NewItemCard(imagePath: 'images/salesimages/mengreen.jpeg', title: 'Mens Green Collar Shirt', price: '\$22'),
                ],
              ),
              const SizedBox(height: 150), // Extra space for bottom padding
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        ],
        selectedItemColor: const Color(0xFFFF0000),
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String title;

  const CategoryItem({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class NewItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  const NewItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150, // Adjusted height for better visual balance
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.favorite_border,
                  color : Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Add to cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}