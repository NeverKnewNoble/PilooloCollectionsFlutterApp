import 'package:flutter/material.dart';
import 'package:piloolo/components/Product%20Detail/detail.dart';
import 'package:piloolo/frappe_api_calls/ulr_base.dart'; // Import base URL for images

class ProductCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Combine baseUrl with imagePath to form the full URL
    final fullImageUrl = Uri.parse(baseUrl).resolve(imagePath).toString();

    return GestureDetector(
      onTap: () {
        // Navigate to ProductDetailsScreen with the product details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              imagePath: fullImageUrl,
              title: title,
              price: price,
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
                width: imageWidth,
                child: Image.network(
                  fullImageUrl, // Use the full image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price, // Correctly interpolate the price
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFFFF0000),
                        ),
                      ),
                    ],
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
