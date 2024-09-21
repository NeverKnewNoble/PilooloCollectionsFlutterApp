import 'package:flutter/material.dart';

class ShoppingCartAction extends StatelessWidget {
  const ShoppingCartAction({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(right: 8.0), // Add some spacing on the right
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle add to cart action
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Set border radius
              ),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero, // Remove padding
              elevation: 0, // Removes the elevation (shadow/border)
              minimumSize: const Size(40, 30), // Set minimum size for the button
            ),
            child: const Icon(
              Icons.add_shopping_cart,
              color: Colors.black, // Icon color
              size: 22,
            ),
          ),
          Positioned(
            right: 13, // Adjust position for the dot
            top: 10, // Adjust position for the dot
            child: Container(
              height: 15,
              width: 15,
              decoration: const BoxDecoration(
                color: Color(0xFFFF0000), // Dot color
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '0', // The integer value (0)
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 12, // Font size for the number
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
