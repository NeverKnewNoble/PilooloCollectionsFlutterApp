import 'package:flutter/material.dart';
import 'package:piloolo/components/currency.dart';
import 'package:piloolo/main/category/category_gender_page.dart'; // Default page
import 'package:piloolo/main/category/pages/men_page.dart'; // Men page
import 'package:piloolo/main/category/pages/trad_wear.dart';
import 'package:piloolo/main/category/pages/women_page.dart'; // Women page

class TopNavigationBar extends StatefulWidget {
  final int selectedIndex;

  const TopNavigationBar({super.key, required this.selectedIndex});

  @override
  TopNavigationBarState createState() => TopNavigationBarState();
}

class TopNavigationBarState extends State<TopNavigationBar> {
  // Function to handle navigation with custom page transition
  void _onItemTapped(int index) {
  Widget page;
  switch (index) {
    case 0:
      page = CategoryGenderPage(currencySign: currencySign);
      break;
    case 1:
      page = const MenPage();
      break;
    case 2:
      page = const WomenPage();
      break;
    case 3:
      page = const TradWearPage();
      break;
    default:
      page = CategoryGenderPage(currencySign: currencySign);
  }

  // Push the new page with a slide transition
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);  // Start from right
        const end = Offset.zero;  // End at current page position
        const curve = Curves.ease;

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
    return Container(
      color: const Color.fromARGB(255, 255, 181, 181), // Background color for the top navigation bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('All', 0),
          _buildNavItem('Men', 1),
          _buildNavItem('Women', 2),
          _buildNavItem('Traditional', 3),
        ],
      ),
    );
  }

  // Helper widget to build navigation items
  Widget _buildNavItem(String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index), // Handle navigation
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.selectedIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}