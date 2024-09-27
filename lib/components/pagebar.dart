import 'package:flutter/material.dart';
import 'package:piloolo/main/account/account.dart';
import 'package:piloolo/main/cart/cart.dart';
import 'package:piloolo/main/category/category_gender_page.dart';
import 'package:piloolo/main/home/home.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final AppBar? appBar;
  final Color? backgroundColor;
  final Widget? drawer; // Add the drawer parameter as Widget

  const MainScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    this.appBar,
    this.backgroundColor,
    this.drawer, // Make drawer optional
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

    Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const CategoryGenderPage();
        break;
      case 2:
        page = const CartPage(); // Example placeholder
        break;
      case 3:
        page = const ProfilePage(); // Example placeholder
        break;
      default:
        page = const HomePage();
    }

    // Use PageRouteBuilder for smooth transition
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Start from below
          const end = Offset.zero; // End at current page position
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
      backgroundColor: widget.backgroundColor ?? Colors.white, // Apply the background color
      drawer: widget.drawer, // Use the drawer in Scaffold
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category ), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Me'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFF0000),
        unselectedItemColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 255, 181, 181),
        onTap: _onItemTapped,
      ),
    );
  }
}
