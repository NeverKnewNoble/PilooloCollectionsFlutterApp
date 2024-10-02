import 'package:flutter/material.dart';
import 'package:piloolo/frappe_api_calls/api_service.dart';
import 'package:piloolo/components/displays_items.dart';
import 'package:piloolo/components/currency.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;

  const SearchPage({super.key, required this.searchQuery});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  late Future<List<Product>> futureFilteredProducts;

  Future<String> _convertPrice(double priceInUSD) async {
    // Convert the price to the selected currency
    return await calculatePrice(priceInUSD, currency);
  }

  @override
  void initState() {
    super.initState();
    // Fetch filtered products based on search query
    futureFilteredProducts = ApiService().filterProducts(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search Results'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Product>>(
          future: futureFilteredProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found'));
            } else {
              final products = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final priceInDouble = double.tryParse(product.price.toString()) ?? 0.0;

                  return FutureBuilder<String>(
                    future: _convertPrice(priceInDouble),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ProductCard(
                          imagePath: product.imagePath,
                          title: product.title,
                          price: '$currencySign${snapshot.data}',
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
