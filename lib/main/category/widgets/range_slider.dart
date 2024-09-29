import 'package:flutter/material.dart';

/// Flutter code sample for [RangeSlider].

void main() => runApp(const RangeSliderExampleApp());

class RangeSliderExampleApp extends StatelessWidget {
  const RangeSliderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: RangeSliderExample(),
      ),
    );
  }
}

class RangeSliderExample extends StatefulWidget {
  const RangeSliderExample({super.key});

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add some padding around the content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
        children: [
          const Text(
            'Price Range',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16), // Add some spacing after the text

          // Row for "From" and "To" input fields
          Row(
            children: [
              SizedBox(
                width: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    // Handle value change for "From" box if necessary
                  },
                ),
              ),
              const SizedBox(width: 16), // Spacing between "From" and "To" elements

              // "To" input
              const Text(
                '> = <',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8), // Spacing between text and input box
              SizedBox(
                width: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    // Handle value change for "To" box if necessary
                  },
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
