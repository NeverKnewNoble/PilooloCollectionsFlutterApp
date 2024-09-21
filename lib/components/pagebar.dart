import 'package:flutter/material.dart';
import 'package:piloolo/pages_main/home/home.dart';
// Import other pages as needed
// import 'package:piloolo/pages_main/event/event_plan.dart';
// import 'package:piloolo/pages_main/reports/daily_report.dart';
// import 'package:piloolo/pages_main/account/account_info.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final int selectedIndex;

  const MainScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
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
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const EventPlan()),
      //   (route) => false,
      // );
    } else if (index == 2) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const DailyReport()),
      //   (route) => false,
      // );
    } else if (index == 3) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AccountInfo(fullName: globalFullName ?? 'User'), // Use the global variable
      //   ),
      //   (route) => false,
      // );
    }
    // Add more navigation options for other indices if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
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
