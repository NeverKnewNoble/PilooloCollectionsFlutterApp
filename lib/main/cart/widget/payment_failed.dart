// import 'package:flutter/material.dart';
// import 'package:piloolo/main/cart/payment.dart';
//
// class PaymentFailedPage extends StatefulWidget {
//   final String location;
//   final String address;
//   final String city;
//   final String zipCode;
//   final VoidCallback? onRetry; // Add onRetry as an optional callback
//
//   const PaymentFailedPage({
//     super.key,
//     required this.location,
//     required this.address,
//     required this.city,
//     required this.zipCode,
//     this.onRetry, // Optional onRetry parameter
//   });
//
//   @override
//   State<PaymentFailedPage> createState() => _PaymentFailedPageState();
// }
//
// class _PaymentFailedPageState extends State<PaymentFailedPage>
//     with TickerProviderStateMixin {
//   bool _showCrossMark = false;
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize animation controller
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//
//     // Start animation with a delay
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         _showCrossMark = true;
//         _controller.forward(); // Start the scale animation
//       });
//
//       // Automatically navigate back to the PaymentPage after the animation
//       Future.delayed(const Duration(seconds: 2), () {
//         if (widget.onRetry != null) {
//           widget.onRetry!(); // Call the onRetry callback if provided
//         } else if (mounted) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PaymentPage(
//                 location: widget.location,
//                 address: widget.address,
//                 city: widget.city,
//                 zipCode: widget.zipCode,
//               ), // Navigate back to PaymentPage
//             ),
//           );
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose(); // Dispose animation controller
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.redAccent, // A more vibrant red color
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Animated scaling container
//             ScaleTransition(
//               scale: CurvedAnimation(
//                 parent: _controller,
//                 curve: Curves.elasticOut,
//               ),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 width: _showCrossMark ? 150 : 55,
//                 height: _showCrossMark ? 150 : 55,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 20,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: _showCrossMark
//                     ? const Icon(Icons.close, color: Colors.red, size: 80)
//                     : const CircularProgressIndicator(
//                         color: Colors.white, strokeWidth: 6),
//               ),
//             ),
//             const SizedBox(height: 20),
//             AnimatedOpacity(
//               opacity: _showCrossMark ? 1 : 0,
//               duration: const Duration(milliseconds: 500),
//               child: Column(
//                 children: const [
//                   Text(
//                     'Payment Failed',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Something went wrong.\nPlease try again later.',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PaymentFailedPage extends StatelessWidget {
  final String location;
  final String address;
  final String city;
  final String zipCode;
  final VoidCallback onRetry;

  const PaymentFailedPage({
    super.key,
    required this.location,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Payment Failed',
              style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'We could not process your payment at this time.\nPlease try again later.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Retry Payment', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
