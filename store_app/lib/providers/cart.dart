import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmonunt => _items
    .values
    .map((item) => item.price * item.quantity)
    .reduce((first, next) => first + next);

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(productId,
       (item) => CartItem(
          id: item.id,
          title: item.title,
          quantity: item.quantity + 1,
          price: item.price,
        )
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        )
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
