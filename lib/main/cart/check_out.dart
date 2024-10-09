import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:piloolo/main/cart/payment.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCountry = 'Ghana';
  String _phonePrefix = '+233';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _stateProvinceController = TextEditingController();

  final Map<String, String> _countryPhonePrefixes = {
    'Ghana': '+233',
    'USA': '+1',
    'UK': '+44',
    'Canada': '+1',
  };

  @override
  void initState() {
    super.initState();
    loadLocalData();
  }

  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        _selectedCountry = prefs.getString('location') ?? 'Ghana';
        _phonePrefix = _countryPhonePrefixes[_selectedCountry!]!;
        _emailController.text = prefs.getString('email') ?? '';
        _firstNameController.text = prefs.getString('first_name') ?? '';
        _lastNameController.text = prefs.getString('last_name') ?? '';
        _phoneController.text = prefs.getString('phone_number')?.replaceFirst(_phonePrefix, '') ?? '';
        _cityController.text = prefs.getString('city') ?? '';
        _zipCodeController.text = prefs.getString('postzip_code') ?? '';
        _address1Controller.text = prefs.getString('address_line_1') ?? '';
        _address2Controller.text = prefs.getString('address_line_2_optional') ?? '';
        _stateProvinceController.text = prefs.getString('stateprovidence_optional') ?? '';
      });
    }
  }

  void _showEditWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please go to Account Information to change your details.')),
    );
  }

  bool areFieldsEmpty() {
    return _emailController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _zipCodeController.text.isEmpty ||
        _address1Controller.text.isEmpty ||
        _stateProvinceController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Shipping Address',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              
              // Email Field (Read-only)
              _buildReadOnlyTextField(_emailController, 'Email', Icons.email),
              const SizedBox(height: 16),

              // Country Dropdown (Read-only)
              _buildReadOnlyDropdown(),
              const SizedBox(height: 16),

              // First Name (Read-only)
              _buildReadOnlyTextField(_firstNameController, 'First Name', Icons.person),
              const SizedBox(height: 16),

              // Last Name (Read-only)
              _buildReadOnlyTextField(_lastNameController, 'Last Name', Icons.person_outline),
              const SizedBox(height: 16),

              // Phone Number with Prefix (Read-only)
              _buildReadOnlyPhoneField(),
              const SizedBox(height: 16),

              // City (Read-only)
              _buildReadOnlyTextField(_cityController, 'City', Icons.location_city),
              const SizedBox(height: 16),

              // State/Province (Read-only)
              _buildReadOnlyTextField(_stateProvinceController, 'State/Province (Optional)', Icons.location_on),
              const SizedBox(height: 16),

              // Post/Zip Code (Read-only)
              _buildReadOnlyTextField(_zipCodeController, 'Post/Zip Code', Icons.local_post_office),
              const SizedBox(height: 16),

              // Address Line 1 (Read-only)
              _buildReadOnlyTextField(_address1Controller, 'Address Line 1', Icons.home),
              const SizedBox(height: 16),

              // Address Line 2 (Optional) (Read-only)
              _buildReadOnlyTextField(_address2Controller, 'Address Line 2 (Optional)', Icons.home_outlined),
              const SizedBox(height: 32),

              // Next Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && !areFieldsEmpty()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          location: _selectedCountry!,
                          address: _address1Controller.text,
                          city: _cityController.text,
                          zipCode: _zipCodeController.text,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields before proceeding.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for building read-only text fields
  Widget _buildReadOnlyTextField(TextEditingController controller, String labelText, IconData icon) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: _showEditWarning,
    );
  }

  // Helper method for building the phone field (read-only)
  Widget _buildReadOnlyPhoneField() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(_phonePrefix, style: const TextStyle(fontSize: 16)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: _phoneController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              filled: true,
              fillColor: Colors.white,
            ),
            onTap: _showEditWarning,
          ),
        ),
      ],
    );
  }

  // Helper method for building read-only dropdown field
  Widget _buildReadOnlyDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      items: _countryPhonePrefixes.keys.map((String country) {
        return DropdownMenuItem(
          value: country,
          child: Text(country),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Location',
        prefixIcon: const Icon(Icons.location_on, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: null, // Disable dropdown
    );
  }
}
