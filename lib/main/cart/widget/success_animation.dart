import 'package:flutter/material.dart';

class SuccessAnimation extends StatefulWidget {
  final VoidCallback onComplete;

  const SuccessAnimation({super.key, required this.onComplete});

  @override
  SuccessAnimationState createState() => SuccessAnimationState();
}

class SuccessAnimationState extends State<SuccessAnimation> {
  bool _showCheckMark = false;

  @override
  void initState() {
    super.initState();

    // Animate the transition
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showCheckMark = true;
      });

      // Trigger onComplete after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        widget.onComplete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Make the full screen red
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _showCheckMark ? 150 : 55, // Adjusted size to fit on screen
              height: _showCheckMark ? 150 : 55,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: _showCheckMark
                  ? const Icon(Icons.check, color: Colors.red, size: 80)
                  : const CircularProgressIndicator(color: Colors.white),
            ),
            const SizedBox(height: 20), // Add spacing between elements
            if (_showCheckMark) ...[
              const Text(
                'Purchased',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Thank you for shopping with Piloolo Collections',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
