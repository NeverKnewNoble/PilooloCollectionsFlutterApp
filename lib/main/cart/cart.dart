import 'package:flutter/material.dart';
import 'package:piloolo/main/cart/check_out.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/Product%20Detail/detail.dart'; // Import detail page

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cart;

    Widget buildQuantityControl(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          icon == Icons.add
              ? cartProvider.incrementQuantity(index)
              : cartProvider.decrementQuantity(index);
        },
        child: Icon(icon, size: 20),
      );
    }

    return MainScaffold(
      selectedIndex: 2, // Ensure the correct index for the bottom navigation bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Use Flexible instead of Expanded to allow the list to scroll if content overflows
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16), // Reduce padding as checkout box is not overlapping
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  // Use item.image as it contains the full URL
                  return GestureDetector(
                    onTap: () {
                      // Navigate to ProductDetailsScreen with the cart item details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            imagePath: item.image, // Pass the full image URL
                            title: item.title, // Pass the title
                            price: item.price.toString(), // Convert price to string
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Item Image
                            Container(
                              height: 100,
                              width: 78,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade200,
                              ),
                              child: Image.network(
                                item.image, // Use item.image as it contains the full URL
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Handle image load error
                                  return const Icon(Icons.broken_image);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Item Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _truncateTitle(item.title),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  // Size Display
                                  Row(
                                    children: [
                                      Text(
                                        '\$${item.price.toStringAsFixed(2)}', // String interpolation for price
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Size: ${item.size}', // Display the size
                                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Quantity Control
                                  Container(
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(255, 255, 181, 181),
                                      border: Border.all(color: const Color.fromARGB(255, 255, 181, 181), width: 2),
                                    ),
                                    child: Row(
                                      children: [
                                        buildQuantityControl(Icons.remove, index),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${item.quantity}', // String interpolation for quantity
                                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        const SizedBox(width: 10),
                                        buildQuantityControl(Icons.add, index),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Stagnant Delete Button
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(index);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red, size: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Checkout Box
            buildCheckOutBox(cartProvider),
          ],
        ),
      ),
    );
  }

  // Helper function to truncate title
  String _truncateTitle(String title) {
    // Split the title into words
    final words = title.split(' ');

    // Check if the word count exceeds 3
    if (words.length > 3) {
      // Return the first 3 words joined by spaces and add ellipsis
      return '${words.sublist(0, 3).join(' ')}...';
    } else {
      // If 3 or fewer words, return the title as is
      return title;
    }
  }

  // Checkout Box Widget
  Widget buildCheckOutBox(CartProvider cartProvider) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
              ),
              Text(
                '\$${cartProvider.totalPrice().toStringAsFixed(2)}', // 2 decimal places for subtotal
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '\$${cartProvider.totalPrice().toStringAsFixed(2)}', // 2 decimal places for total
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Checkout Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF0000),
              minimumSize: const Size(double.infinity, 55),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOutPage()));
              // Add your checkout functionality here
            },
            child: const Text(
              "Check Out",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
