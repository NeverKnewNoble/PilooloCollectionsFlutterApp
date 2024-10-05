import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutInfoPage extends StatefulWidget {
  const CheckOutInfoPage({super.key});

  @override
  State<CheckOutInfoPage> createState() => _CheckOutInfoPageState();
}

class _CheckOutInfoPageState extends State<CheckOutInfoPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCountry = 'Ghana';
  String _phonePrefix = '+233';

  final TextEditingController _emailController = TextEditingController(); // Added email controller
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _stateProvinceController = TextEditingController();

  // Countries and their respective phone prefixes
  final Map<String, String> _countryPhonePrefixes = {
    'Ghana': '+233',
    'USA': '+1',
    'UK': '+44',
    'Canada': '+1',
  };

  @override
  void initState() {
    super.initState();
    loadLocalData(); // Load saved data when initializing the page
  }

  // Load data from local storage
  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        _selectedCountry = prefs.getString('location') ?? 'Ghana';
        _phonePrefix = _countryPhonePrefixes[_selectedCountry!]!;
        _emailController.text = prefs.getString('email') ?? ''; // Load email
        _firstNameController.text = prefs.getString('first_name') ?? '';
        _lastNameController.text = prefs.getString('last_name') ?? '';
        _phoneController.text = prefs.getString('phone_number')?.replaceFirst(_phonePrefix, '') ?? '';
        _cityController.text = prefs.getString('city') ?? '';
        _stateProvinceController.text = prefs.getString('stateprovidence_optional') ?? '';
        _zipCodeController.text = prefs.getString('postzip_code') ?? '';
        _address1Controller.text = prefs.getString('address_line_1') ?? '';
        _address2Controller.text = prefs.getString('address_line_2_optional') ?? '';
      });
    }
  }

  // Save data locally in the app
  Future<void> saveLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('location', _selectedCountry!);
    await prefs.setString('email', _emailController.text); // Save email
    await prefs.setString('first_name', _firstNameController.text);
    await prefs.setString('last_name', _lastNameController.text);
    await prefs.setString('phone_number', '$_phonePrefix${_phoneController.text}');
    await prefs.setString('city', _cityController.text);
    await prefs.setString('stateprovidence_optional', _stateProvinceController.text);
    await prefs.setString('postzip_code', _zipCodeController.text);
    await prefs.setString('address_line_1', _address1Controller.text);
    await prefs.setString('address_line_2_optional', _address2Controller.text);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved')),
      );
    }
  }

  bool isNewDocument() {
    // Replace this logic with how you determine if the document is new or existing
    return true; // Return true for new documents
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Shipping Address',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 4),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Location Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                items: _countryPhonePrefixes.keys.map((String country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                    _phonePrefix = _countryPhonePrefixes[newValue!]!;
                  });
                },
              ),
              const SizedBox(height: 16),
              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Phone Number
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(_phonePrefix),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // City
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // State/Province (Optional)
              TextFormField(
                controller: _stateProvinceController,
                decoration: const InputDecoration(
                  labelText: 'State/Province (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Post/Zip Code
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(
                  labelText: 'Post/Zip Code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your post/zip code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Address Line 1
              TextFormField(
                controller: _address1Controller,
                decoration: const InputDecoration(
                  labelText: 'Address Line 1',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Address Line 2 (Optional)
              TextFormField(
                controller: _address2Controller,
                decoration: const InputDecoration(
                  labelText: 'Address Line 2 (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveLocalData(); // Save data locally in the app
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 16,
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
}
