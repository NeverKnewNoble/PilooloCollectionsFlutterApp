import 'package:flutter/material.dart';
import 'package:piloolo/main/cart/widget/cart_provider.dart';
import 'package:piloolo/main/category/category_gender_page.dart';
import 'package:piloolo/main/home/home.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';


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
      // locale: const Locale('en', 'US'), // Set your desired locale here
      // supportedLocales: const [
      //   Locale('en', 'US'), 
      // ],
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      title: 'Piloolo',
      debugShowCheckedModeBanner: false,
      home: const CategoryGenderPage(), // Ensure this page is under the provider's scope
       routes: {
        'HomePage': (context) => const HomePage(), // Define the route for the HomePage
        // Add other routes if necessary
      },
    );
  }
}
