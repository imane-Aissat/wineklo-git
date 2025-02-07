import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/restaurateur.dart'; 

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
}
