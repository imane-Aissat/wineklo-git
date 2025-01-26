/*import 'package:userworkside/services/auth_service.dart';
import '../models/user_model.dart';

class AuthService {
Future<void> saveUserData(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value); // Store a string in SharedPreferences
}

  static Future<User?> getUser(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userData = prefs.getString('user_$email');
    return User.fromJson(userData);
      return null; // User not found
  }
}*/
