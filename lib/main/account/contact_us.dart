import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  // Function to launch the URL (website link)
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // Change to match your brand's theme
        title: const Text('Contact Us', style: TextStyle(color: Colors.black)),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Get in Touch with Piloolo Collections',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),

            // About Piloolo Collections Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Piloolo Collections offers a range of high-quality clothing, from trendy casuals to elegant formals, designed to fit every style and occasion. We believe in providing fashion that speaks to every individual’s unique taste while keeping comfort and quality a priority.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16.0),

            // Call to Action - Visit Our Website
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Visit our website for the latest collections and updates:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),

            // Website Link
            GestureDetector(
              onTap: () => _launchURL('https://piloolo.erpxpand.com'),
              child: const Text(
                'https://piloolo.erpxpand.com',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Contact Details Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'We\'d Love to Hear From You!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const Text(
              'Feel free to reach out to us for any inquiries, feedback, or assistance.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16.0),

            // Email Section
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.email, color: Colors.black),
              title: const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('info@piloolocollections.com'),
              onTap: () => _launchURL('mailto:info@piloolocollections.com'),
            ),

            // Phone Section
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.phone, color: Colors.black),
              title: const Text('Phone', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('+1 234 567 8900'),
              onTap: () => _launchURL('tel:+12345678900'),
            ),

            // // Social Media Section
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16.0),
            //   child: Text(
            //     'Follow Us',
            //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     // Social Media Icon Buttons (Replace with your own icons and URLs)
            //     IconButton(
            //       icon: Image.asset('assets/icons/facebook.png'), // Replace with your Facebook icon
            //       onPressed: () => _launchURL('https://facebook.com/piloolocollections'),
            //     ),
            //     IconButton(
            //       icon: Image.asset('assets/icons/instagram.png'), // Replace with your Instagram icon
            //       onPressed: () => _launchURL('https://instagram.com/piloolocollections'),
            //     ),
            //     IconButton(
            //       icon: Image.asset('assets/icons/twitter.png'), // Replace with your Twitter icon
            //       onPressed: () => _launchURL('https://twitter.com/piloolocollect'),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 32.0),

            // Footer Message
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Thank you for choosing Piloolo Collections. We look forward to serving you!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
