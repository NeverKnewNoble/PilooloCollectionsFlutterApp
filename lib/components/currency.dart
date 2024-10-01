// currency.dart

String currency = 'USD';
String currencySign = '\$';

// List of available currency options
final List<String> currencies = ['USD', 'GHC', 'GBP'];

// Function to get the currency sign based on the selected currency
String getCurrencySign(String currency) {
  switch (currency) {
    case 'USD':
      return '\$';
    case 'GHC':
      return '₵';
    case 'GBP':
      return '£';
    default:
      return '\$';
  }
}
