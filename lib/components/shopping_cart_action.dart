import 'package:flutter/material.dart';
import 'package:piloolo/main/cart/cart.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:provider/provider.dart';

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
              // Navigate to the CartPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
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
          // The Cart Count Dot
          Positioned(
            right: 13, // Adjust position for the dot
            top: 10, // Adjust position for the dot
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF0000), // Dot color
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${cartProvider.cart.length}', // Display the count of items in the cart
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 12, // Font size for the number
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
