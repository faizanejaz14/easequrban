import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/animal.dart';
import '../providers/wishlist_provider.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'animal_detail_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Animal> animals = [
    Animal(
      id: '1',
      name: 'White Lamb',
      category: 'Lamb',
      price: 50000,
      imageUrl: 'assets/images/whitelamb-removebg.png',
    ),
    Animal(
      id: '2', 
      name: 'Brown Goat',
      category: 'Goat',
      price: 60000,
      imageUrl: 'assets/images/browngoat-removebg.png',
    ),
    Animal(
      id: '3',
      name: 'Black Cow',
      category: 'Cow',
      price: 120000,
      imageUrl: 'assets/images/blackcow-removebg.png',
    ),
    Animal(
      id: '4',
      name: 'Tall Camel',
      category: 'Camel',
      price: 200000,
      imageUrl: 'assets/images/tallcamel-removebg.png',
    ),
  ];

  String selectedSort = 'None';
  String selectedCategory = 'All';

  List<String> categories = ['All', 'Lamb', 'Goat', 'Cow', 'Camel'];

  List<Animal> get filteredAnimals {
    List<Animal> filtered = animals;
    if (selectedCategory != 'All') {
      filtered = filtered.where((animal) => animal.category == selectedCategory).toList();
    }
    if (selectedSort == 'Price: Low to High') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSort == 'Price: High to Low') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('EaseQurban - Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedSort,
                  items: ['None', 'Price: Low to High', 'Price: High to Low']
                      .map((sort) => DropdownMenuItem(
                            value: sort,
                            child: Text(sort),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedSort = val);
                    }
                  },
                ),
                DropdownButton<String>(
                  value: selectedCategory,
                  items: categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedCategory = val);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: filteredAnimals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final animal = filteredAnimals[index];
                final isInWishlist = wishlistProvider.isInWishlist(animal.id);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimalDetailScreen(animal: animal),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(
                                  animal.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: IconButton(
                                  icon: Icon(
                                    isInWishlist ? Icons.favorite : Icons.favorite_border,
                                    color: isInWishlist ? Colors.red : Colors.white,
                                  ),
                                  onPressed: () {
                                    wishlistProvider.toggleWishlist(animal);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                animal.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                animal.category,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Rs ${animal.price.toStringAsFixed(0)}',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
