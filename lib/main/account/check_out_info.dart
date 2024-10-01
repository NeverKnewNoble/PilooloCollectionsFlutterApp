import 'package:flutter/material.dart';

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

class CheckOutInfoPage extends StatefulWidget {
  const CheckOutInfoPage({super.key});


  @override
  State<CheckOutInfoPage> createState() => _CheckOutInfoPageState();
}

class _CheckOutInfoPageState extends State<CheckOutInfoPage> {
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
              // Country Dropdown
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

              // Phone Number with Prefix
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
              const SizedBox(height: 32),

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

              const Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center contents in the row
                children: [
                  SizedBox(width: 15), // Adjust spacing as necessary

                  Text(
                    'Save your Information',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  SizedBox(width: 15), // Adjust spacing between text and switch

                  SwitchExample(),
                ],
              ),

              // const SizedBox(height: 32),

              // // Next Button
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       // Pass the collected data to the PaymentPage
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => PaymentPage(
              //             location: _selectedCountry!,
              //             address: _address1Controller.text,
              //             city: _cityController.text,
              //             zipCode: _zipCodeController.text,
              //           ),
              //         ),
              //       );
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: const Size(double.infinity, 55),
              //     backgroundColor: Colors.black,
              //   ),
              //   child: const Text(
              //     'Next',
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
