import 'package:flutter/material.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:piloolo/main/category/pages/men_page.dart';
import 'package:piloolo/main/home/home.dart';
import 'package:piloolo/main/cart/widget/success_animation.dart'; // Import your success animation page
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(), // Wrap MyApp as a child
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piloolo',
      debugShowCheckedModeBanner: false,
      home: const MenPage(), // Keep MenPage as the home page
      routes: {
        'HomePage': (context) => const HomePage(), // Home page route
        '/paymentSuccess': (context) => SuccessAnimation(
              onComplete: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'HomePage', (route) => false);
              },
            ), // Add the route for the success animation
      },
    );
  }
}
