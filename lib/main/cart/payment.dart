import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:piloolo/main/cart/widget/success_animation.dart'; // Import the animation

class PaymentPage extends StatefulWidget {
  final String location;
  final String address;
  final String city;
  final String zipCode;

  const PaymentPage({
    super.key,
    required this.location,
    required this.address,
    required this.city,
    required this.zipCode,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _payWithCard = false;
  bool _payWithMoMo = false;
  bool _showAnimation = false; // To control animation

  // Mock shipping fee, VAT, and checkout information (replace with real data)
  final double shippingFee = 5.00;
  final double vatPercentage = 0.15; // 15% VAT

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Show the animation if _showAnimation is true
    if (_showAnimation) {
      return SuccessAnimation(
        onComplete: () {
          // Access the CartProvider instance
          final cartProvider = Provider.of<CartProvider>(context, listen: false);
          
          // Clear the cart
          cartProvider.clearCart();
          
          // Navigate back to HomePage
          Navigator.pushNamedAndRemoveUntil(context, 'HomePage', (route) => false);
        },
      );
    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Methods',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Card Option
              RadioListTile<bool>(
                value: true,
                groupValue: _payWithCard,
                onChanged: (value) {
                  setState(() {
                    _payWithCard = value!;
                    _payWithMoMo = false; // Deselect MoMo option
                  });
                },
                title: const Text('Card'),
                activeColor: Colors.red,
              ),

              // Card Details Form (only if card option is selected)
              if (_payWithCard) ...[
                const SizedBox(height: 10),
                // Card Number
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    prefixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),

                // Expiry Date and CVV
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Expiry Date',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 10),

              // Paystack (MoMo) Option
              RadioListTile<bool>(
                value: true,
                groupValue: _payWithMoMo,
                onChanged: (value) {
                  setState(() {
                    _payWithMoMo = value!;
                    _payWithCard = false; // Deselect Card option
                  });
                },
                title: const Text('Paystack (MoMo)'),
                activeColor: Colors.red,
              ),

              if (_payWithMoMo)
                ElevatedButton(
                  onPressed: () {
                    // Paystack MoMo logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'images/paystack.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Continue with Paystack',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 60),

              // Display Checkout Info Section
              buildCheckoutInfoSection(),

              const SizedBox(height: 50),

              // Checkout Box with Shipping Fee, VAT, and Submit Order button
              buildCheckOutBox(cartProvider),
            ],
          ),
        ),
      ),
    );
  }

  // Display Checkout Information Section
  Widget buildCheckoutInfoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Address:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('Location: ${widget.location}'),
          Text('Address: ${widget.address}'),
          Text('City: ${widget.city}'),
          Text('Zip Code: ${widget.zipCode}'),
        ],
      ),
    );
  }

  // Checkout Box Widget
  Widget buildCheckOutBox(CartProvider cartProvider) {
    final subtotal = cartProvider.totalPrice();
    final vatAmount = subtotal * vatPercentage;
    final total = subtotal + shippingFee + vatAmount;

    return Container(
      height: 250,
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
                '\$${subtotal.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Shipping Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shipping Fee",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
              ),
              Text(
                '\$${shippingFee.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // VAT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "VAT",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
              ),
              Text(
                '\$${vatAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Total with VAT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Order Total (VAT Included)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Submit Order Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF0000),
              minimumSize: const Size(double.infinity, 55),
            ),
            onPressed: () {
              // Trigger the animation
              setState(() {
                _showAnimation = true;
              });
            },
            child: Text(
              "Submit Order (\$${total.toStringAsFixed(2)})",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
