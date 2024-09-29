import 'package:flutter/material.dart';
import 'package:piloolo/main/category/widgets/range_slider.dart';

class MenLeftDrawer extends StatelessWidget {
  final Function(String) onCategoryTap;

  const MenLeftDrawer({super.key, required this.onCategoryTap});

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
                  'Men Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            // Drawer Menu Items
            buildListTile(context, 'All', onCategoryTap),
            buildListTile(context, 'Suit | Coat', onCategoryTap, 'images/salesimages/real pic/cat-office.jpg'),
            buildListTile(context, 'Shirt', onCategoryTap, 'images/salesimages/real pic/shirt.jpg'),
            buildListTile(context, 'T-shirt', onCategoryTap, 'images/salesimages/real pic/catt-shirt.jpg'),
            buildListTile(context, 'Trousers', onCategoryTap, 'images/salesimages/real pic/carttrousers.jpg'),
            buildListTile(context, 'Shorts', onCategoryTap, 'images/salesimages/real pic/m-shorts.jpg'),
            buildListTile(context, 'Hoodies', onCategoryTap, 'images/salesimages/real pic/1721025213a33f67ae5f77d58e2987c90821a7c102_thumbnail_405x552.jpeg'),
            buildListTile(context, 'Jeans', onCategoryTap, 'images/salesimages/real pic/m-jeans.jpeg'),
            buildListTile(context, 'Shoes', onCategoryTap, 'images/salesimages/real pic/m-shoes.jpg'),
            const SizedBox(height: 150),

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

  ListTile buildListTile(BuildContext context, String title, Function(String) onTap, [String? imagePath]) {
    return ListTile(
      leading: imagePath != null
          ? Container(
              width: 40, // Set the width of the circle
              height: 40, // Set the height of the circle
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : const SizedBox(width: 40, height: 10),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap(title); // Call the onCategoryTap callback with the tapped category name
      },
    );
  }
}
