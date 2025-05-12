import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist'),
      ),
      body: wishlistProvider.wishlist.isEmpty
          ? Center(child: Text('No items in your wishlist yet.'))
          : ListView.builder(
              itemCount: wishlistProvider.wishlist.length,
              itemBuilder: (context, index) {
                final animal = wishlistProvider.wishlist[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(animal.imageUrl, width: 50, fit: BoxFit.cover),
                    title: Text(animal.name),
                    subtitle: Text(animal.category),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        wishlistProvider.toggleWishlist(animal);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
