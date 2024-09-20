import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                const Text(
                'Forgot password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const Text(
              'We\'ll send you an email to reset your password.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
            
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',

                  filled: true, // Enables the background color
                  fillColor:Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    borderSide: const BorderSide(color: Color.fromARGB(255, 255, 181, 181), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    borderSide: const BorderSide(color: Color(0xFFFF0000), width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement password reset logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 5.20, horizontal: 115.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
              ),
              child: const Text('Reset Password', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}