import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(EaseQurbanApp());
}

class EaseQurbanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'EaseQurban',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: LoginScreen(),
      ),
    );
  }
}
