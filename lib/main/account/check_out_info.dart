import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:piloolo/components/currency.dart'; // Import currency utility

class CheckOutInfoPage extends StatefulWidget {
  const CheckOutInfoPage({super.key});

  @override
  State<CheckOutInfoPage> createState() => _CheckOutInfoPageState();
}

class _CheckOutInfoPageState extends State<CheckOutInfoPage> {
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
        _stateProvinceController.text = prefs.getString('stateprovidence_optional') ?? '';
        _zipCodeController.text = prefs.getString('postzip_code') ?? '';
        _address1Controller.text = prefs.getString('address_line_1') ?? '';
        _address2Controller.text = prefs.getString('address_line_2_optional') ?? '';

        _updateCurrencyBasedOnCountry(_selectedCountry!); // Update currency based on country
      });
    }
  }

  Future<void> saveLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('location', _selectedCountry!);

    await prefs.setString('email', _emailController.text);
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
        const SnackBar(content: Text('Data saved successfully!')),
      );
    }
  }


  // Update the global currency and sign based on the selected country
  void _updateCurrencyBasedOnCountry(String country) async {
    final prefs = await SharedPreferences.getInstance();
    
    setState(() {
      // Map country to its currency
      switch (country) {
        case 'Ghana':
          currency = 'GH₵';
          break;
        case 'USA':
          currency = 'USD';
          break;
        case 'UK':
          currency = 'GBP';
          break;
        default:
          currency = 'USD'; // Default to USD if no match
      }

      // Update the global currency sign based on the new currency
      currencySign = getCurrencySign(currency);

      // Save the updated currency to SharedPreferences
      prefs.setString('currency', currency);
    });
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
              // Email Field
              _buildTextField(_emailController, 'Email', TextInputType.emailAddress,
                  'Please enter a valid email', Icons.email),
              const SizedBox(height: 16),

              // Location Dropdown
              _buildDropdownField(),
              const SizedBox(height: 16),

              // First Name Field
              _buildTextField(_firstNameController, 'First Name', TextInputType.text,
                  'Please enter your first name', Icons.person),
              const SizedBox(height: 16),

              // Last Name Field
              _buildTextField(_lastNameController, 'Last Name', TextInputType.text,
                  'Please enter your last name', Icons.person_outline),
              const SizedBox(height: 16),

              // Phone Number Field
              _buildPhoneField(),
              const SizedBox(height: 16),

              // City Field
              _buildTextField(_cityController, 'City', TextInputType.text,
                  'Please enter your city', Icons.location_city),
              const SizedBox(height: 16),

              // State/Province Field (Optional)
              _buildTextField(_stateProvinceController, 'State/Province (Optional)', TextInputType.text,
                  null, Icons.location_on),
              const SizedBox(height: 16),

              // Post/Zip Code Field
              _buildTextField(_zipCodeController, 'Post/Zip Code', TextInputType.number,
                  'Please enter your post/zip code', Icons.local_post_office),
              const SizedBox(height: 16),

              // Address Line 1 Field
              _buildTextField(_address1Controller, 'Address Line 1', TextInputType.streetAddress,
                  'Please enter your address', Icons.home),
              const SizedBox(height: 16),

              // Address Line 2 Field (Optional)
              _buildTextField(_address2Controller, 'Address Line 2 (Optional)', TextInputType.streetAddress,
                  null, Icons.home_outlined),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveLocalData();
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
                  'Save',
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

  // Helper method for building text fields
  Widget _buildTextField(TextEditingController controller, String labelText, TextInputType inputType, String? validationMsg, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: inputType,
      validator: (value) {
        if (validationMsg != null && (value == null || value.isEmpty)) {
          return validationMsg;
        }
        return null;
      },
    );
  }

  // Helper method for building the phone field
  Widget _buildPhoneField() {
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
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              filled: true,
              fillColor: Colors.white,
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
    );
  }

  // Helper method for building the dropdown field
  Widget _buildDropdownField() {
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
      onChanged: (String? newValue) {
        setState(() {
          _selectedCountry = newValue;
          _phonePrefix = _countryPhonePrefixes[newValue!]!;
          _updateCurrencyBasedOnCountry(newValue); // Update the currency based on selected country
        });
      },
    );
  }
}
