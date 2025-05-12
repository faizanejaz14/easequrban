// import 'package:flutter/material.dart';
// import '../models/animal.dart';

// class WishlistProvider with ChangeNotifier {
//   final List<Animal> _wishlist = [];

//   List<Animal> get wishlist => _wishlist;

//   void toggleWishlist(Animal animal) {
//     if (_wishlist.any((item) => item.id == animal.id)) {
//       _wishlist.removeWhere((item) => item.id == animal.id);
//     } else {
//       _wishlist.add(animal);
//     }
//     notifyListeners();
//   }

//   bool isInWishlist(String animalId) {
//     return _wishlist.any((item) => item.id == animalId);
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/animal.dart';

class WishlistProvider with ChangeNotifier {
  List<Animal> _wishlist = [];

  List<Animal> get wishlist => _wishlist;

  WishlistProvider() {
    loadWishlist();
  }

  void toggleWishlist(Animal animal) {
    if (_wishlist.any((item) => item.id == animal.id)) {
      _wishlist.removeWhere((item) => item.id == animal.id);
    } else {
      _wishlist.add(animal);
    }
    saveWishlist();
    notifyListeners();
  }

  bool isInWishlist(String animalId) {
    return _wishlist.any((item) => item.id == animalId);
  }

  void saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wishlistJson =
        _wishlist.map((animal) => jsonEncode({
          'id': animal.id,
          'name': animal.name,
          'category': animal.category,
          'price': animal.price,
          'imageUrl': animal.imageUrl,
        })).toList();
    prefs.setStringList('wishlist', wishlistJson);
  }

  void loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? wishlistJson = prefs.getStringList('wishlist');

    if (wishlistJson != null) {
      _wishlist = wishlistJson.map((animalStr) {
        final data = jsonDecode(animalStr);
        return Animal(
          id: data['id'],
          name: data['name'],
          category: data['category'],
          price: (data['price']).toDouble(),
          imageUrl: data['imageUrl'],
        );
      }).toList();
      notifyListeners();
    }
  }
}
