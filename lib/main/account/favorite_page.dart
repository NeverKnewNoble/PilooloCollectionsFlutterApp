import 'package:flutter/material.dart';
import 'package:piloolo/components/displays_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // To decode JSON

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  // Load favorited items from local storage
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteData = prefs.getStringList('favoriteItems') ?? [];

    // Cast each item explicitly as Map<String, dynamic>
    setState(() {
      favoriteItems = favoriteData.map((item) {
        return jsonDecode(item) as Map<String, dynamic>;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: favoriteItems.isEmpty
          ? const Center(child: Text('No favorite items found.'))
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.6,
              ),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final product = favoriteItems[index];

                return ProductCard(
                  imagePath: product['imagePath'],
                  title: product['title'],
                  price: product['price'],
                );
              },
            ),
    );
  }
}
