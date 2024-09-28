import 'package:flutter/material.dart';
import 'package:piloolo/main/category/widgets/range_slider.dart';

class WomenLeftDrawer extends StatelessWidget {
  const WomenLeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Set background color to white
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 181, 181),
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                'Women Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              )
              
            ),
            // Drawer Menu Items
            ListTile(
              leading: Container(
                width: 40, // Set the width of the circle
                height: 40, // Set the height of the circle
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-dress.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Dresses',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Home
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-top.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Tops',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Profile
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-blouse.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Blouses',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-trousers.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Trousers',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-t-shirt.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('T-shirt',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-suit.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Suits | Blazzers',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-skirt.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Skirts',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-jeans.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Jeans',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/salesimages/real pic/w-shoes.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Shoes',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
            const SizedBox(height: 200),
        
        
            // Add the RangeSlider widget
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: RangeSliderExample(),
            ),
        
        
          ],
        ),
      ),
    );
  }
}
