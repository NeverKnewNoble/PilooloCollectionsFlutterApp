import 'package:flutter/material.dart';
import 'package:piloolo/main/category/category_gender_page.dart';
// import 'package:piloolo/pages/splash.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Piloolo',
      debugShowCheckedModeBanner: false,
      home: CategoryGenderPage(),
    );
  }
}

