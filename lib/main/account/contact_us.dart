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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Contact Us', style: TextStyle(color: Colors.black, fontSize: 20)),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with image
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Get in Touch with Piloolo Collections',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // About Piloolo Collections Section with custom font size
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Piloolo Collections offers high-quality clothing, from trendy casuals to elegant formals. Our focus is on fashion that speaks to your unique style while ensuring comfort and quality.',
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 24.0),

            // Call to Action - Visit Our Website with card style
            const Text(
              'Visit our website for the latest collections and updates:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap: () => _launchURL('https://piloolo.erpxpand.com'),
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: const [
                      Icon(Icons.web, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'https://piloolo.erpxpand.com',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            // Contact Details Section
            const Text(
              'We\'d Love to Hear From You!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Reach out to us for any inquiries, feedback, or assistance.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24.0),

            // Email Section with clean layout
            _buildContactTile(Icons.email, 'Email', 'info@piloolocollections.com', () => _launchURL('mailto:info@piloolocollections.com')),

            // Phone Section with clean layout
            _buildContactTile(Icons.phone, 'Phone', '+1 234 567 8900', () => _launchURL('tel:+12345678900')),
            
            const SizedBox(height: 32.0),

            // Social Media Section
            const Text(
              'Follow Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSocialMediaIconButton(Icons.facebook, 'https://facebook.com/piloolocollections'),
                _buildSocialMediaIconButton(Icons.photo_camera, 'https://instagram.com/piloolocollections'),
                _buildSocialMediaIconButton(Icons.message, 'https://twitter.com/piloolocollect'),
              ],
            ),
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

  // Helper method for building contact tiles
  ListTile _buildContactTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  // Helper method for building social media buttons
  IconButton _buildSocialMediaIconButton(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, color: Colors.blueAccent, size: 32),
      onPressed: () => _launchURL(url),
    );
  }
}
