import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piloolo/components/pagebar.dart';
import 'package:piloolo/components/shopping_cart_action.dart';
import 'package:piloolo/main/account/check_out_info.dart';
import 'package:piloolo/main/account/contact_us.dart';
import 'package:piloolo/main/account/favorite_page.dart';
import 'package:piloolo/main/account/order_history.dart';
import 'package:piloolo/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  File? _image; // Store the picked image
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  String _firstName = ''; // Store the user's first name

  @override
  void initState() {
    super.initState();
    loadUserName(); // Load user's first name on init
  }

  // Method to load the user's first name from local storage
  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('first_name') ?? 'Your Name'; // Default to "John Doe" if not found
    });
  }

  // Method to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Update the selected image
      });
    }
  }

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
                  // Profile Picture with GestureDetector to trigger image picking
                  GestureDetector(
                    onTap: _pickImage, // Pick image when tapped
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? FileImage(_image!) // Display selected image
                          : const AssetImage('assets/images/default_avatar.png') as ImageProvider, // Default placeholder image
                      backgroundColor: Colors.grey.shade200, // Background color
                      child: _image == null
                          ? const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    _firstName, // Use the dynamically loaded first name
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
                          );
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsPage()));
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
