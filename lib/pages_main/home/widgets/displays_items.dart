import 'package:flutter/material.dart';

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
    this.imageHeight = 250, // Default image height
    this.imageWidth = double.infinity, // Default image width (full width)
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Set background color to white
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Remove border radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanding the image to take up available space
          Expanded(
            child: SizedBox(
              width: imageWidth,
              child: Image.asset(
                imagePath,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        // color: Color.fromARGB(255, 255, 181, 181),
                        color: Color(0xFFFF0000),
                      ),
                    ),
                    // Cart button
                    ElevatedButton(
                      onPressed: () {
                        // Handle add to cart action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Set border radius
                        ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero, // Remove padding
                        minimumSize: const Size(40, 30), // Set minimum size for the button
                      ),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black, // Icon color
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
