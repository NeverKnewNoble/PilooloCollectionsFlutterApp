import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';
import 'package:piloolo/frappe_api_calls/order.dart';
import 'package:provider/provider.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:piloolo/main/cart/widget/payment_failed.dart';
// import 'package:piloolo/main/cart/widget/success_animation.dart';
import 'package:piloolo/components/currency.dart';
import 'package:uuid/uuid.dart';

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
  final double shippingFee = 5.00;
  final double vatPercentage = 0.15; // 15% VAT

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

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
              const Text(
                'Payment',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              buildCheckoutInfoSection(),
              const SizedBox(height: 30),
              buildCheckOutBox(cartProvider),
            ],
          ),
        ),
      ),
    );
  }

void handlePaystackPayment(double total) async {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  final transactionReference = Uuid().v4();
  final int paystackAmount = (total * 100).toInt();

  final request = PaystackTransactionRequest(
    reference: transactionReference,
    secretKey: "sk_test_df8dd769c39dd807c2db732ab1b5c98e66643288",
    email: "user@example.com",
    amount: paystackAmount.toDouble(),
    currency: PaystackCurrency.ghs,
    channel: [
      PaystackPaymentChannel.mobileMoney,
      PaystackPaymentChannel.card,
    ],
  );

  try {
    final initializedTransaction = await PaymentService.initializeTransaction(request);

    if (!mounted) return;

    if (!initializedTransaction.status) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(initializedTransaction.message),
      ));
      return;
    }

    final successUrl = Uri.parse('/paymentSuccess');
    await PaymentService.showPaymentModal(
      context,
      callbackUrl: successUrl.toString(),
      transaction: initializedTransaction,
      onClosing: () async {
        if (!mounted) return;

        // Verify the transaction immediately after the modal closes
        final verifiedResponse = await PaymentService.verifyTransaction(
          initializedTransaction.data?.reference ?? transactionReference,
          paystackSecretKey: "sk_test_df8dd769c39dd807c2db732ab1b5c98e66643288",
        );

        if (!mounted) return;

        if (verifiedResponse.status) {
          // Transaction successful
          try {
            final orderService = OrderService();
            await orderService.createOrder(context);

            if (!mounted) return;

            cartProvider.clearCart();
            Navigator.pushReplacementNamed(context, '/paymentSuccess');
          } catch (e) {
            if (kDebugMode) {
              print('Error during order creation: $e');
            }
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order creation failed. Please try again.')),
            );
          }
        } else {
          // Transaction failed
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentFailedPage(
                location: widget.location,
                address: widget.address,
                city: widget.city,
                zipCode: widget.zipCode,
                onRetry: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentPage(
                        location: widget.location,
                        address: widget.address,
                        city: widget.city,
                        zipCode: widget.zipCode,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error processing payment: $e');
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error processing payment. Please try again.')),
    );
  }
}


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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
            ),
            onPressed: () {
              if (mounted) {
                handlePaystackPayment(total);  // Initiate the payment process
              }
            },
            child: Text(
              "Submit Order ($currencySign${total.toStringAsFixed(2)})",
              style: const TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

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








