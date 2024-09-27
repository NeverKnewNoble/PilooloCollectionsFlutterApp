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
  RangeValues _currentRangeValues = const RangeValues(40, 80);

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
          const SizedBox(height: 16), // Add some spacing between the text and slider
          RangeSlider(
            values: _currentRangeValues,
            max: 100,
            divisions: 5,
            activeColor: const Color(0xFFFF0000), // Set active (selected) color
            inactiveColor: const Color.fromARGB(255, 255, 181, 181), // Set inactive (unselected) color
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
        ],
      ),
    );
  }
}
