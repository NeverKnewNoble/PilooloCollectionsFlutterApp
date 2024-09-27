import 'package:flutter/material.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:piloolo/components/pagebar.dart';

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
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        Container(
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
                            children: [
                              // Item Image
                              Container(
                                height: 100,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Image.asset(item.image),
                              ),
                              const SizedBox(width: 10),
                              // Item Details
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item.category,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "\$${item.price}",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Remove Item and Quantity Control
                        Positioned(
                          top: 35,
                          right: 35,
                          child: Column(
                            children: [
                              // Remove Item Button
                              IconButton(
                                onPressed: () {
                                  cartProvider.removeItem(index);
                                },
                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              ),
                              const SizedBox(height: 10),
                              // Quantity Control
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                  border: Border.all(color: Colors.grey.shade400, width: 2),
                                ),
                                child: Row(
                                  children: [
                                    buildQuantityControl(Icons.add, index),
                                    const SizedBox(width: 10),
                                    Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 10),
                                    buildQuantityControl(Icons.remove, index),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                "\$${cartProvider.totalPrice()}",
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
                "\$${cartProvider.totalPrice()}",
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
