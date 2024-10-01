import 'package:flutter/material.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/account/check_out_info.dart';
import 'package:piloolo/pages/login.dart';

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
            // Profile Picture & Name Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: const AssetImage('images/salesimages/menblue.jpeg'),
                    backgroundColor: Colors.grey.shade200, // Background color
                  ),
                  const SizedBox(height: 16),
                  // Name
                  const Text(
                    'John Doe', // Replace with dynamic name if needed
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      // color: Color(0xFFFF6347), // Tomato color for contrast
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Divider line with a gradient effect
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade400,
                indent: 16,
                endIndent: 16,
              ),
            ),
            const SizedBox(height: 20),

            // Options list section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  children: [
                    // Account Info Card
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        
                        leading: const Icon(Icons.person, color: Colors.black),
                        title: const Text('Account Information'),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOutInfoPage()));
                          // Handle navigation to Account Info
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Orders Card
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag, color: Colors.black),
                        title: const Text('My Orders'),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        onTap: () {
                          // Handle navigation to Orders
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Wishlist Card
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: const Icon(Icons.favorite, color: Colors.black),
                        title: const Text('Wishlist'),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        onTap: () {
                          // Handle navigation to Wishlist
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Contact Us Card
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: const Icon(Icons.contact_mail, color: Colors.black),
                        title: const Text('Contact Us'),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        onTap: () {
                          // Handle navigation to Contact Us
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                    // Logout Card
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: const Icon(Icons.logout, color: Colors.black),
                        title: const Text('Logout'),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
