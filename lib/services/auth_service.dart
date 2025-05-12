// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Save user credentials (signup)
  static Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
    required String address,
    required String contact,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    // Check if user already exists
    if (prefs.containsKey('user_$email')) {
      return false; // User already registered
    }

    final userData = {
      'email': email,
      'password': password,
      'name': name,
      'address': address,
      'contact': contact,
    };

    await prefs.setString('user_$email', userData.toString());
    return true;
  }

  // Login user
  static Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_$email')) return false;

    final userDataString = prefs.getString('user_$email')!;
    final correctPassword = _extractValue(userDataString, 'password');
    return correctPassword == password;
  }

  // Optional: extract any value from stored user string
  static String? _extractValue(String data, String key) {
    final RegExp regExp = RegExp('$key: (.*?)[,}]');
    final match = regExp.firstMatch(data);
    return match?.group(1);
  }
}
