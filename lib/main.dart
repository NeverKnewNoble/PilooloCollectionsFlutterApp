import 'package:flutter/material.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:piloolo/main/category/category_gender_page.dart';
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
    return const MaterialApp(
      title: 'Piloolo',
      debugShowCheckedModeBanner: false,
      home: CategoryGenderPage(), // Ensure this page is under the provider's scope
    );
  }
}
