import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/restaurateur.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class RestaurateursCubit extends Cubit<List<Restaurateur>?> {
  RestaurateursCubit() : super(null);

  static const String baseUrl = "http://127.0.0.1:5000"; 

  Future<void> loadAllRestaurateurs() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/all/restaurateurs/"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Restaurateur> restaurateurs = data.map((json) {
          return Restaurateur.fromJson(json as Map<String, dynamic>);
        }).toList();
        emit(restaurateurs);
      } else {
        print("Failed to load restaurateurs, status code: ${response.statusCode}");
        emit([]);
      }
    } catch (e) {
      print("Error fetching restaurateurs: $e");
      emit([]);
    }
  }

  Future<void> loadAllFavorites(int foodieID) async {
    try {
      emit(null);
      final response = await http.get(Uri.parse("$baseUrl/all/restaurateurs/favorites/$foodieID"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Restaurateur> restaurateurs = data.map((json) {
          return Restaurateur.fromJson(json as Map<String, dynamic>);
        }).toList();
        emit(restaurateurs);
      } else {
        print("Failed to load favorite restaurateurs, status code: ${response.statusCode}");
        emit([]);
      }
    } catch (e) {
      print("Error fetching favorite restaurateurs: $e");
      emit([]);
    }
  }


  Future<void> loadFavoritesProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    emit([]);
    return;
  }

  final response = await http.get(
    Uri.parse('$baseUrl/load/favorites/profile'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body); 
    final List<Restaurateur> restaurateurs = jsonData.map((json) => Restaurateur.fromJson(json)).toList();

    emit(restaurateurs); 
  } else {
    emit([]);
  }
}



}
