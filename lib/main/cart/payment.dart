import 'package:flutter/material.dart';
import 'package:piloolo/frappe_api_calls/order.dart';
import 'package:provider/provider.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:piloolo/main/cart/widget/success_animation.dart'; 
import 'package:piloolo/components/currency.dart';

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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              const Text(
                'Payment Methods',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Card Option
              buildPaymentOption(
                title: 'Pay with Card',
                isSelected: _payWithCard,
                onTap: () {
                  setState(() {
                    _payWithCard = true;
                    _payWithMoMo = false;
                  });
                },
                icon: Icons.credit_card,
              ),

              // Card Details Form (only if card option is selected)
              if (_payWithCard) buildCardDetailsForm(),

              const SizedBox(height: 10),

              // Paystack (MoMo) Option
              buildPaymentOption(
                title: 'Paystack (MoMo)',
                isSelected: _payWithMoMo,
                onTap: () {
                  setState(() {
                    _payWithMoMo = true;
                    _payWithCard = false;
                  });
                },
                icon: Icons.mobile_friendly,
              ),

              if (_payWithMoMo)
                buildPaystackButton(),

              const SizedBox(height: 20),

              // Display Checkout Info Section
              buildCheckoutInfoSection(),

              const SizedBox(height: 30),

              // Checkout Box with Shipping Fee, VAT, and Submit Order button
              buildCheckOutBox(cartProvider),
            ],
          ),
        ),
      ),
    );
  }

  // Payment Option Selector
  Widget buildPaymentOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red[50] : Colors.white,
          border: Border.all(color: isSelected ? Colors.red : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.red : Colors.black, size: 30),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected ? Colors.red : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // Card Details Form Widget
  Widget buildCardDetailsForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
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
      ),
    );
  }

  // Paystack Button for MoMo Payment
  Widget buildPaystackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          // Paystack MoMo logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/paystack.png',
              width: 35,
              height: 35,
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Text('Location: ${widget.location}', style: const TextStyle(fontSize: 16)),
          Text('Address: ${widget.address}', style: const TextStyle(fontSize: 16)),
          Text('City: ${widget.city}', style: const TextStyle(fontSize: 16)),
          Text('Zip Code: ${widget.zipCode}', style: const TextStyle(fontSize: 16)),
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          buildSummaryRow("Subtotal", subtotal),
          const SizedBox(height: 10),
          buildSummaryRow("Shipping Fee", shippingFee),
          const SizedBox(height: 10),
          buildSummaryRow("VAT", vatAmount),
          const Divider(height: 30, thickness: 1),
          buildSummaryRow("Order Total (VAT Included)", total, isTotal: true),
          const SizedBox(height: 20),

          // Submit Order Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
            ),
            onPressed: () async {
              // Call the API to create the order
              final orderService = OrderService();
              await orderService.createOrder(context);

              // Trigger the animation
              setState(() {
                _showAnimation = true;
              });
            },
            child: Text(
              "Submit Order ($currencySign${total.toStringAsFixed(2)})",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
          )

        ],
      ),
    );
  }

  // Build Summary Row Widget for Checkout Box
  Widget buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            fontSize: isTotal ? 18 : 16,
            color: isTotal ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          '$currencySign${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            fontSize: isTotal ? 18 : 16,
          ),
        ),
      ],
    );
  }
}