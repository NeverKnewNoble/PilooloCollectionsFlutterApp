import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;

  const ProductDetailsScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedSize = ''; // To store the selected size
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black), // Ensure back button is visible
        actions: const [
          ShoppingCartAction(), // Use the shopping cart action from the new file
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image section
            SizedBox(
              height: 400,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath), // Display image passed to the details screen
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Size selection
                  const Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Size buttons container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20), // Rounded edges
                      border: Border.all(color: Colors.grey.shade300), // Border color
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                        return _SizeButton(
                          size: size,
                          isSelected: _selectedSize == size,
                          onTap: () {
                            setState(() {
                              _selectedSize = size; // Assign selected size to variable
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Quantity control
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  buildQuantityControl(),

                  const SizedBox(height: 16),

                  // In-stock text
                  const Text(
                    'In Stock',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),

                  const SizedBox(height: 32),

                  // Price & Add to Cart button
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 181, 181),
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                      border: Border.all(color: Colors.grey.shade300), // Optional border color
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          'Price:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.price, // Use the price passed to the details screen
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Check if size is selected
                            if (_selectedSize.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please select a size before adding to the cart.",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              // Add the item to cart with selected details
                              cartProvider.addItem(CartItem(
                                image: widget.imagePath, // Use the image passed to the details screen
                                title: widget.title, // Use the title passed to the details screen
                                price: double.parse(widget.price.replaceAll('\$', '')),
                                size: _selectedSize,
                                quantity: quantity,
                              ));

                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Item added to cart!",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Change button color here
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          ),
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build quantity control widget
  Widget buildQuantityControl() {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the container
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(color: Colors.grey.shade300), // Optional border color
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10), // Padding inside the container
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (quantity > 1) quantity--;
              });
            },
            child: const Icon(Icons.remove, size: 20),
          ),
          const SizedBox(width: 10),
          Text(
            '$quantity',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                quantity++;
              });
            },
            child: const Icon(Icons.add, size: 20),
          ),
        ],
      ),
    );
  }
}

class _SizeButton extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback onTap;

  const _SizeButton({
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red : const Color.fromARGB(255, 255, 181, 181), // Change color based on selection
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
      ),
      child: Text(
        size,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black), // Text color changes on selection
      ),
    );
  }
}
