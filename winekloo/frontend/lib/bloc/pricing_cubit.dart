import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/pricing_model.dart'; 

class PricingCubit extends Cubit<List<Pricing>> {
  PricingCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; 

  Future<void> loadPricings() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/pricing"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final pricings = data.map((e) => Pricing.fromJson(e)).toList();
        emit(pricings);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching pricings: $e");
      emit([]);
    }
  }
}