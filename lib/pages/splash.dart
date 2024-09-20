import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piloolo/pages/intro.dart'; // Ensure correct path for IntroPage

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Enable immersive mode for full-screen experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Perform the delay, then navigate if the widget is still mounted
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const IntroPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Reset system UI mode to normal
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
    super.dispose(); // Always call super.dispose()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/logo_nobg.png', // Ensure this path is correct
          width: 400, // Adjust the image width
          height: 300, // Adjust the image height as needed
          errorBuilder: (context, error, stackTrace) {
            return const Text('Error loading image'); // Handle error gracefully
          },
        ),
      ),
    );
  }
}
