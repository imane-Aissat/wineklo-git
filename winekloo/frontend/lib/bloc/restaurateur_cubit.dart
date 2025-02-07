import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/restaurateur.dart';

class RestaurateurCubit extends Cubit<Restaurateur?> {
  RestaurateurCubit() : super(null);

  static const String baseUrl = "http://127.0.0.1:5000"; 
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
  
}
