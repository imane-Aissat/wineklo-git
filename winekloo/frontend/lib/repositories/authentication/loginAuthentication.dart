
class LoginAuthentication {
 Future<Map<String, dynamic>> login(String email, String password) async {
  await Future.delayed(const Duration(seconds: 1)); 
  if (email == "foodie@example.com" && password == "password") {
    return {'isLoggedIn': true, 'role': 'foodie'};
  } else if (email == "restaurant@example.com" && password == "password") {
    return {'isLoggedIn': true, 'role': 'restaurant'};
  } else {
    throw Exception('Invalid credentials');
  }
}

}
