import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  // Add item to the cart
  void addItem(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  // Increment item quantity
  void incrementQuantity(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  // Decrement item quantity
  void decrementQuantity(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
      notifyListeners();
    }
  }

  // Remove item from the cart
  void removeItem(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  // Get total price
  double totalPrice() {
    return _cart.fold(0, (total, item) => total + (item.price * item.quantity));
  }
}

class CartItem {
  final String image;
  final String title;
  final double price;
  final String size; // Add the size field
  int quantity;

  CartItem({
    required this.image,
    required this.title,
    required this.price,
    required this.size, // Initialize size
    this.quantity = 1,
  });
}


