import 'package:flutter/material.dart';
// import '../models/cart_item.dart';
import 'checkout_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  // final List<CartItem> cartItems = [
  //   CartItem(
  //     id: 'c1',
  //     animalId: '1',
  //     name: 'White Lamb',
  //     price: 50000,
  //     butcherService: false,
  //     deliveryDay: 'First Day',
  //   ),
  //   CartItem(
  //     id: 'c2',
  //     animalId: '3',
  //     name: 'Black Cow',
  //     price: 120000,
  //     butcherService: true,
  //     deliveryDay: 'Second Day',
  //   ),
  // ];

  // double getTotalAdvance() {
  //   double total = 0.0;
  //   for (var item in cartItems) {
  //     total += item.price * 0.5; // 50% advance
  //     if (item.butcherService) {
  //       total += 5000; // Fixed butcher cost
  //     }
  //   }
  //   return total;
  // }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            //child: ListView.builder(
            child: cartProvider.cartItems.isEmpty
              ? Center(child: Text('Your cart is empty.'))
              : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(item.animalImage, width: 50, fit: BoxFit.cover),
                    title: Text(item.name),
                    subtitle: Text(
                      'Delivery: ${item.deliveryDay}\n'
                      '${item.butcherService ? 'With Butcher Service' : 'Alive Delivery'}'
                      '\n50% Advance Amount: Rs ${(item.price * 0.5).toStringAsFixed(0)}'
                    ),
                    // trailing: Row(
                    //   children: [
                    //     Text('Rs ${(item.price * 0.5).toStringAsFixed(0)}'),
                    //     IconButton(
                    //       icon: Icon(Icons.delete, color: Colors.red),
                    //       onPressed: () {
                    //         cartProvider.removeItem(item.id);
                    //       },
                    //     )
                    //   ],
                    // ),
                  
                    trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cartProvider.removeItem(item.id);
                          },
                        )
                  ),
                );
              },
            ),
          ),
          if (cartProvider.cartItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Total Advance Payment:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                   'Rs ${cartProvider.totalAdvance.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                  child: Text('Proceed to Checkout'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
