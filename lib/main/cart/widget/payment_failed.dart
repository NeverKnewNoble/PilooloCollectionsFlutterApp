import 'package:flutter/material.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage>
    with TickerProviderStateMixin {
  bool _showCrossMark = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start animation with a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showCrossMark = true;
        _controller.forward(); // Start the scale animation
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent, // A more vibrant red color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated scaling container
            ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Curves.elasticOut,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _showCrossMark ? 150 : 55,
                height: _showCrossMark ? 150 : 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: _showCrossMark
                    ? const Icon(Icons.close, color: Colors.red, size: 80)
                    : const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 6),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _showCrossMark ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: const [
                  Text(
                    'Payment Failed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Something went wrong.\nPlease try again later.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
