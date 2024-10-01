import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:piloolo/main/account/account.dart';
import 'package:piloolo/main/cart/cart.dart';
import 'package:piloolo/main/category/category_gender_page.dart';
import 'package:piloolo/main/home/home.dart';
import 'package:piloolo/components/currency.dart';


class MainScaffold extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final AppBar? appBar;
  final Color? backgroundColor;
  final Widget? drawer;

  const MainScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    this.appBar,
    this.backgroundColor,
    this.drawer,
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
        page = CategoryGenderPage(currencySign: currencySign);
        break;
      case 2:
        page = const CartPage();
        break;
      case 3:
        page = const ProfilePage();
        break;
      default:
        page = const HomePage();
    }

    // Navigate to the new page with a smooth transition
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
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
      backgroundColor: widget.backgroundColor ?? Colors.white,
      drawer: widget.drawer,
      // Wrap GNav in a container to apply borderRadius
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 181, 181),
            borderRadius: BorderRadius.circular(30), // Apply rounded corners to the container
          ),
          child: GNav(
            gap: 8,
            padding: const EdgeInsets.all(16),
            activeColor: Colors.white,
            tabBorderRadius: 30, // Set border radius for tabs
            color: Colors.black,
            tabBackgroundColor: const Color(0xFFFF0000),
            selectedIndex: _selectedIndex,
            onTabChange: (index) => _onItemTapped(index),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.category,
                text: 'Category',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Me',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
