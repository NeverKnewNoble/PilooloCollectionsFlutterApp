import 'package:flutter/material.dart';
import 'package:piloolo/components/Product%20Detail/detail.dart';
import 'package:piloolo/frappe_api_calls/ulr_base.dart'; // Import base URL for images
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // To encode and decode JSON

class ProductCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final double imageHeight;
  final double imageWidth;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    this.imageHeight = 250,
    this.imageWidth = double.infinity,
  });

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  // Check if the item is already favorited
  Future<void> checkFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteItems = prefs.getStringList('favoriteItems') ?? [];
    setState(() {
      // Check if any of the stored items match the product title
      isFavorited = favoriteItems.any((item) => jsonDecode(item)['title'] == widget.title);
    });
  }

  // Toggle the favorite status and save it locally
  Future<void> toggleFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteItems = prefs.getStringList('favoriteItems') ?? [];

    final productData = jsonEncode({
      'title': widget.title,
      'imagePath': widget.imagePath,
      'price': widget.price,
    });

    setState(() {
      if (isFavorited) {
        // Remove the product if it's already favorited
        favoriteItems.removeWhere((item) => jsonDecode(item)['title'] == widget.title);
      } else {
        // Add the product to favorites
        favoriteItems.add(productData);
      }
      isFavorited = !isFavorited;
    });

    await prefs.setStringList('favoriteItems', favoriteItems);
  }

  @override
  Widget build(BuildContext context) {
    // Combine baseUrl with imagePath to form the full URL
    final fullImageUrl = Uri.parse(baseUrl).resolve(widget.imagePath).toString();

    return GestureDetector(
      onTap: () {
        // Navigate to ProductDetailsScreen with the product details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              imagePath: fullImageUrl,
              title: widget.title,
              price: widget.price,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanding the image to take up available space
            Expanded(
              child: SizedBox(
                width: widget.imageWidth,
                child: Stack(
                  children: [
                    Image.network(
                      fullImageUrl, // Use the full image URL
                      fit: BoxFit.cover,
                    ),
                    // Heart Icon for favoriting
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: isFavorited ? Colors.red : Colors.grey,
                        ),
                        onPressed: toggleFavoriteStatus,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
