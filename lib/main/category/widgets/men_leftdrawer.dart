import 'package:flutter/material.dart';
import 'package:piloolo/main/category/widgets/range_slider.dart';

class MenLeftDrawer extends StatelessWidget {
  final Function(String) onCategoryTap;
  final Function(double, double) onPriceRangeChanged;

  const MenLeftDrawer({super.key, required this.onCategoryTap, required this.onPriceRangeChanged});

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
            buildListTile(context, 'Suit | Coat', onCategoryTap),
            buildListTile(context, 'Shirt', onCategoryTap),
            buildListTile(context, 'T-shirt', onCategoryTap),
            buildListTile(context, 'Trousers', onCategoryTap),
            buildListTile(context, 'Shorts', onCategoryTap),
            buildListTile(context, 'Hoodies', onCategoryTap),
            buildListTile(context, 'Jeans', onCategoryTap),
            buildListTile(context, 'Shoes', onCategoryTap),
            const SizedBox(height: 150),

            // Add the RangeSlider widget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: RangeSliderExample(
                onPriceRangeChanged: onPriceRangeChanged, // Pass the price range callback
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, String title, Function(String) onTap) {
    return ListTile(
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
