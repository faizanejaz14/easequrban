import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../models/cart_item.dart';
import 'cart_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;

  AnimalDetailScreen({required this.animal});

  void addToCart(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addToCart(animal);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${animal.name} added to Cart!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              animal.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal.name,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    animal.category,
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: Rs ${animal.price.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 22, color: Colors.green),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This is a healthy ${animal.category.toLowerCase()} perfect for Eid sacrifice. Guaranteed quality and timely delivery.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => addToCart(context),
                      child: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
