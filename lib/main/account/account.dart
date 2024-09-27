import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 3, // Category index for the bottom navigation
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        actions: const [
          ShoppingCartAction(), // Use the shopping cart action from the new file
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/salesimages/menblue.jpeg'), // Replace with your image path
                  ),
                  SizedBox(width: 16),
                  // Name
                  Text(
                    'John Doe', // Replace with dynamic name if needed
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Divider line
            const Divider(
              thickness: 1,
              color: Colors.grey,
              indent: 16,
              endIndent: 16,
            ),
            // Options list
            Expanded(
              child: ListView(
                children: [
                  // About Us button
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.black),
                    title: const Text('About Us'),
                    onTap: () {
                      // Handle navigation to About Us page
                    },
                  ),
                  // Logout button
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle logout functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
