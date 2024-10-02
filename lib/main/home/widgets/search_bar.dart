import 'package:flutter/material.dart';
import 'package:piloolo/main/home/widgets/search_page.dart';

class MySearchBAR extends StatefulWidget {
  const MySearchBAR({super.key});

  @override
  MySearchBARState createState() => MySearchBARState();
}

class MySearchBARState extends State<MySearchBAR> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(searchQuery: query),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 400,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 181, 181),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _onSearch(context), // Trigger search on submit
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => _onSearch(context), // Trigger search on button press
          ),
        ],
      ),
    );
  }
}
