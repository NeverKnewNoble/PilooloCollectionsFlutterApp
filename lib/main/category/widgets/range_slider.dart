import 'package:flutter/material.dart';

class RangeSliderExample extends StatefulWidget {
  final Function(double, double) onPriceRangeChanged;

  const RangeSliderExample({super.key, required this.onPriceRangeChanged});

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  double _minPrice = 0; // Default minimum price
  double _maxPrice = 1000; // Default maximum price

  // Controller for "From" and "To" text fields
  final TextEditingController _fromPriceController = TextEditingController();
  final TextEditingController _toPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fromPriceController.text = _minPrice.toStringAsFixed(0);
    _toPriceController.text = _maxPrice.toStringAsFixed(0);
  }

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
                  controller: _fromPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Min',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _minPrice = double.tryParse(value) ?? 0;
                      // Emit the price range change
                      widget.onPriceRangeChanged(_minPrice, _maxPrice);
                    });
                  },
                ),
              ),
              const SizedBox(width: 16), // Spacing between "From" and "To" elements

              const Text(
                '> = <',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8), // Spacing between text and input box

              // "To" input
              SizedBox(
                width: 60,
                child: TextField(
                  controller: _toPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Max',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _maxPrice = double.tryParse(value) ?? 1000;
                      // Emit the price range change
                      widget.onPriceRangeChanged(_minPrice, _maxPrice);
                    });
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
