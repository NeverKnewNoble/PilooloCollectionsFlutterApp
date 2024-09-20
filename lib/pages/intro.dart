import 'package:flutter/material.dart';
import 'package:piloolo/pages/login.dart';
import 'package:piloolo/pages/sign_up.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            children: [
              Image.asset(
                'images/logo_nobg.png', // Ensure this path is correct and image is added in pubspec.yaml
                width: 300, // Image takes full width
                height: 100, // Adjust the height as needed
              ),
              const SizedBox(height: 5),
              Image.asset(
                'images/Shopping-gif.gif', // Ensure this path is correct and image is added in pubspec.yaml
                width: 400, // Image takes full width
                height: 400, // Adjust the height as needed
              ),
              const SizedBox(height: 30),
              // Login Button
              SizedBox(
                 height: 40,
                width: double.infinity, // Set width to fill the available space
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFFF0000), // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInPage()
                        ),
                      );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Sign Up Button
              SizedBox(
                width: double.infinity, // Set width to fill the available space
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccountPage()
                        ),
                      );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
