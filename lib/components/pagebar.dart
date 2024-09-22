import 'package:flutter/material.dart';
import 'package:piloolo/main/category/category_gender_page.dart';
import 'package:piloolo/main/home/home.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final AppBar? appBar; // Added appBar parameter

  const MainScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    this.appBar, // Accept the appBar as a parameter
  });

  @override
  MainScaffoldState createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else if (index == 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const CategoryGenderPage()),
        (route) => false,
      );
    } else if (index == 2) {
      // Add navigation to another page (e.g., CartPage)
    } else if (index == 3) {
      // Add navigation to account or profile page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar, // Pass the appBar to Scaffold
      body: widget.body, // Set the body
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.blur_linear), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Me'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFF0000),
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
