import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/restaurateur.dart';

class RestaurateurCubit extends Cubit<Restaurateur?> {
  RestaurateurCubit() : super(null);

  static const String baseUrl = "http://127.0.0.1:5000";

  Future<void> loadProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  print("Token from SharedPreferences: $token"); // Debug statement

  if (token == null) {
    emit(null);
    return;
  }

  final response = await http.get(
    Uri.parse('$baseUrl/restaurateur/logged'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  print("Response Status Code: ${response.statusCode}"); // Debug statement
  print("Response Body: ${response.body}"); // Debug statement

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final restaurateur = Restaurateur.fromJson(data);
    emit(restaurateur);
  } else {
    emit(null);
  }
}

  Future<void> loadRestaurateur(int restaurateurID) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/restaurateur/$restaurateurID"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final restaurateur = Restaurateur.fromJson(data);
        emit(restaurateur);
      } else {
        emit(null);
      }
    } catch (e) {
      print("Error fetching restaurateur: $e");
      emit(null);
    }
  }

  Future<void> updateRestaurateur(Restaurateur updatedRestaurateur) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/restaurateur/${updatedRestaurateur.restaurateurID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedRestaurateur.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final updated = Restaurateur.fromJson(data);
        emit(updated);
      } else {
        print("Failed to update restaurateur: ${response.body}");
      }
    } catch (e) {
      print("Error updating restaurateur: $e");
    }
  }
}
