// import 'package:flutter/material.dart';
// import '../models/cart_item.dart';
// import '../models/animal.dart';

// class CartProvider with ChangeNotifier {
//   final List<CartItem> _cartItems = [];

//   List<CartItem> get cartItems => _cartItems;

//   void addToCart(Animal animal) {
//     _cartItems.add(
//       CartItem(
//         id: DateTime.now().toString(),
//         animalId: animal.id,
//         name: animal.name,
//         price: animal.price,
//         butcherService: false,
//         deliveryDay: 'First Day',
//       ),
//     );
//     notifyListeners();
//   }

//   double get totalAdvance {
//     double total = 0.0;
//     for (var item in _cartItems) {
//       total += item.price * 0.5;
//       if (item.butcherService) {
//         total += 5000;
//       }
//     }
//     return total;
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/animal.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  CartProvider() {
    loadCart();
  }

  void addToCart(Animal animal) {
    _cartItems.add(
      CartItem(
        id: DateTime.now().toString(),
        animalImage:animal.imageUrl,
        animalId: animal.id,
        name: animal.name,
        price: animal.price,
        butcherService: false,
        deliveryDay: 'First Day',
      ),
    );
    saveCart();
    notifyListeners();
  }

  double get totalAdvance {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price * 0.5;
      if (item.butcherService) {
        total += 5000;
      }
    }
    return total;
  }

  void saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson = _cartItems.map((item) => jsonEncode({
          'id': item.id,
          'animalImage': item.animalImage,
          'animalId': item.animalId,
          'name': item.name,
          'price': item.price,
          'butcherService': item.butcherService,
          'deliveryDay': item.deliveryDay,
        })).toList();
    prefs.setStringList('cart', cartJson);
  }

  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cart');

    if (cartJson != null) {
      _cartItems = cartJson.map((itemStr) {
        final data = jsonDecode(itemStr);
        return CartItem(
          id: data['id'],
          animalImage: data['animalImage'],
          animalId: data['animalId'],
          name: data['name'],
          price: (data['price']).toDouble(),
          butcherService: data['butcherService'],
          deliveryDay: data['deliveryDay'],
        );
      }).toList();
      notifyListeners();
    }
  }
  
  void clearCart() async {
    _cartItems.clear(); // Clear the cart list
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart'); // Also clear it from local storage
    notifyListeners(); // Update listeners
  }

  void removeItem(String cartItemId) {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    saveCart();
    notifyListeners();
  }

}
