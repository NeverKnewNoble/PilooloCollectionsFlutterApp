import 'package:flutter/material.dart';
import 'package:piloolo/main/cart/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SwitchExample Widget code added directly here for integration
class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light0 = true;
  bool light1 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          thumbIcon: thumbIcon,
          value: light1,
          activeColor: Colors.green, 
          activeTrackColor: Colors.lightGreen, 
          onChanged: (bool value) {
            setState(() {
              light1 = value;
            });
          },
        ),
      ],
    );
  }
}

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCountry = 'Ghana';
  String _phonePrefix = '+233';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();

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
    loadLocalData();
  }

  // Load data from local storage
  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        _selectedCountry = prefs.getString('location') ?? 'Ghana';
        _phonePrefix = _countryPhonePrefixes[_selectedCountry!]!;
        _firstNameController.text = prefs.getString('first_name') ?? '';
        _lastNameController.text = prefs.getString('last_name') ?? '';
        _phoneController.text = prefs.getString('phone_number')?.replaceFirst(_phonePrefix, '') ?? '';
        _cityController.text = prefs.getString('city') ?? '';
        _zipCodeController.text = prefs.getString('postzip_code') ?? '';
        _address1Controller.text = prefs.getString('address_line_1') ?? '';
        _address2Controller.text = prefs.getString('address_line_2_optional') ?? '';
      });
    }
  }

  // Show warning message if trying to edit fields
  void _showEditWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please go to Account Information to change your details.')),
    );
  }

  // Check if any field is empty before navigating to next page
  bool areFieldsEmpty() {
    return _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _zipCodeController.text.isEmpty ||
        _address1Controller.text.isEmpty;
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
              // Country Dropdown (read-only)
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
                onChanged: null, // Disable dropdown
              ),
              const SizedBox(height: 16),

              // First Name (read-only)
              TextFormField(
                controller: _firstNameController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                onTap: _showEditWarning,
              ),
              const SizedBox(height: 16),

              // Last Name (read-only)
              TextFormField(
                controller: _lastNameController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                onTap: _showEditWarning,
              ),
              const SizedBox(height: 16),

              // Phone Number with Prefix (read-only)
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
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      onTap: _showEditWarning,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // City (read-only)
              TextFormField(
                controller: _cityController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                onTap: _showEditWarning,
              ),
              const SizedBox(height: 16),

              // State/Province (Optional) (read-only)
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'State/Province (Optional)',
                  border: OutlineInputBorder(),
                ),
                onTap: _showEditWarning,
              ),
              const SizedBox(height: 16),

              // Post/Zip Code (read-only)
              TextFormField(
                controller: _zipCodeController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Post/Zip Code',
                  border: OutlineInputBorder(),
                ),
                onTap: _showEditWarning,
              ),
              const SizedBox(height: 16),

              // Address Line 1 (read-only)
              TextFormField(
                controller: _address1Controller,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Address Line 1',
                  border: OutlineInputBorder(),
                ),
                onTap: _showEditWarning,
              ),
              const SizedBox(height: 16),

              // Address Line 2 (Optional) (read-only)
              TextFormField(
                controller: _address2Controller,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Address Line 2 (Optional)',
                  border: OutlineInputBorder(),
                ),
                onTap: _showEditWarning,
              ),
              const SizedBox(height: 16),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15),
                  Text(
                    'Save your Information',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: 15),
                  SwitchExample(),
                ],
              ),

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
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
