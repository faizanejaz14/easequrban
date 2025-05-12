import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
// import 'confirmed_order_screen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool butcherService = false;
  String selectedDay = 'First Day';

  // double basePrice = 100000; // Example base total (you can pass this dynamically)

  double getFinalAmount(double amount) {
    double finalAmount = amount; // Already 50%
  
    if (butcherService) {
      finalAmount += 5000; // fixed butcher service cost
    }
    return finalAmount;
  }

  void _confirmOrder(double amount) {  
    final cartProvider = Provider.of<CartProvider>(context, listen: false); // <-- notice listen: false
    //double amount = cartProvider.totalAdvance; // Already 50%
    //final finalAmount = getFinalAmount(amount); // Cache final amount because butcherService might change
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Order Confirmed!'),
        content: Text(
          //  'Your sacrificial animal will be delivered on $selectedDay.\nTotal Advance Paid: Rs ${getFinalAmount().toStringAsFixed(0)}'),
            'Your sacrificial animal will be delivered on $selectedDay.\nTotal Advance Paid: Rs $amount'),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop(); // Close dialog
              // Navigator.of(context).pop(); // Back to cart or home
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false, // Remove all previous screens
              );
            },
            child: Text('OK'),
          )
        ],
      ),
    );
    cartProvider.clearCart(); // Clear cart after order
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context); 
    double amount = cartProvider.totalAdvance; // Already 50%
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Add Butcher Service (Rs 5000 extra)'),
              value: butcherService,
              onChanged: (val) {
                setState(() {
                  butcherService = val;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Select Delivery Day:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedDay,
              items: ['First Day', 'Second Day', 'Third Day']
                  .map((day) => DropdownMenuItem(
                        value: day,
                        child: Text(day),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedDay = val;
                  });
                }
              },
            ),
            SizedBox(height: 30),
            Text(
              'Total Advance Payment:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
               'Rs ${getFinalAmount(amount).toStringAsFixed(0)}',
              //'Rs $finalAmount',
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            ElevatedButton(
              //onPressed: _confirmOrder(context),
              child: Text('Confirm Order'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () => _confirmOrder(getFinalAmount(amount)),
            ),
          ],
        ),
      ),
    );
  }
}
