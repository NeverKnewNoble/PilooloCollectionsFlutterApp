// currency.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
String currency = 'USD';
String currencySign = '\$';

// List of available currency options
final List<String> currencies = ['USD', 'GHS', 'GBP'];

// Function to get the currency sign based on the selected currency
String getCurrencySign(String currency) {
  switch (currency) {
    case 'USD':
      return '\$';
    case 'GHS':
      return '₵';
    case 'GBP':
      return '£';
    default:
      return '\$';
  }
}



// Function to get the conversion rate from USD to the desired currency
Future<double> getConversionRate(String targetCurrency) async {
  // Map GH₵ to GHS for API consistency
  String mappedCurrency = targetCurrency == 'GHS' ? 'GHS' : targetCurrency;

  // Your API endpoint with access key
  final url = Uri.parse('https://api.exchangerate.host/live?access_key=34be58c102a04e22cf0bee4b094bdaff&currencies=GBP,GHS');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // Extract the rate from 'quotes'
    final quotes = data['quotes'];

    // Construct the key based on the response format, e.g., 'USDGBP' or 'USDGHS'
    String key = 'USD$mappedCurrency';

    // Check if the target currency exists in the response quotes
    if (quotes != null && quotes[key] != null) {
      return quotes[key];
    } else {
      throw Exception('Currency rate not found for $targetCurrency');
    }
  } else {
    throw Exception('Failed to load currency conversion rate');
  }
}



// Function to calculate price based on the selected currency
Future<String> calculatePrice(double usdPrice, String selectedCurrency) async {
  if (selectedCurrency == 'USD') {
    return usdPrice.toStringAsFixed(2);
  }

  final rate = await getConversionRate(selectedCurrency);
  final convertedPrice = usdPrice * rate;

  return convertedPrice.toStringAsFixed(2);
}

