import 'package:flutter/material.dart';

class SuccessAnimation extends StatefulWidget {
  final VoidCallback onComplete;

  const SuccessAnimation({super.key, required this.onComplete});

  @override
  SuccessAnimationState createState() => SuccessAnimationState();
}

class SuccessAnimationState extends State<SuccessAnimation>
    with TickerProviderStateMixin {
  bool _showCheckMark = false;
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
        _showCheckMark = true;
        _controller.forward(); // Start the scale animation
      });

      // Trigger onComplete after the animation ends
      Future.delayed(const Duration(seconds: 2), () {
        widget.onComplete();
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
      backgroundColor: Colors.greenAccent, // A more vibrant color
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
                width: _showCheckMark ? 150 : 55,
                height: _showCheckMark ? 150 : 55,
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
                child: _showCheckMark
                    ? const Icon(Icons.check, color: Colors.green, size: 80)
                    : const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 6),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _showCheckMark ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: const [
                  Text(
                    'Payment Successful',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Thank you for shopping with \nPiloolo Collections',
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