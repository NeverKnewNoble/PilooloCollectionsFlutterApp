import 'package:flutter/material.dart';
import 'package:piloolo/main/category/widgets/range_slider.dart';

class WomenLeftDrawer extends StatelessWidget {
  final Function(String) onCategoryTap;
  final Function(double, double) onPriceRangeChanged;

  const WomenLeftDrawer({super.key, required this.onCategoryTap, required this.onPriceRangeChanged});

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
              ),
            ),
            // Drawer Menu Items
            buildListTile(context, 'All', onCategoryTap),
            buildListTile(context, 'Dresses', onCategoryTap, 'images/salesimages/real pic/w-dress.jpeg'),
            buildListTile(context, 'Tops', onCategoryTap, 'images/salesimages/real pic/w-top.jpg'),
            buildListTile(context, 'Blouses', onCategoryTap, 'images/salesimages/real pic/w-blouse.jpg'),
            buildListTile(context, 'Trousers', onCategoryTap, 'images/salesimages/real pic/w-trousers.jpg'),
            buildListTile(context, 'T-shirt', onCategoryTap, 'images/salesimages/real pic/w-t-shirt.jpeg'),
            buildListTile(context, 'Suits | Blazers', onCategoryTap, 'images/salesimages/real pic/w-suit.jpg'),
            buildListTile(context, 'Skirts', onCategoryTap, 'images/salesimages/real pic/w-skirt.jpg'),
            buildListTile(context, 'Jeans', onCategoryTap, 'images/salesimages/real pic/w-jeans.jpg'),
            buildListTile(context, 'Shoes', onCategoryTap, 'images/salesimages/real pic/w-shoes.jpg'),
            const SizedBox(height: 100),

            // Add the RangeSlider widget for price range filtering
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: RangeSliderExample(
                onPriceRangeChanged: onPriceRangeChanged, // Handle price range changes
              ),
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
