import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/restaurateur_model.dart';

class RestaurateurRepository {
  final database = Supabase.instance.client.from('restaurateur');

  Future createRestaurateur(Restaurateur newRestaurateur) async {
    final response = await database.insert({
      'DiningType': newRestaurateur.diningType,
      'Name': newRestaurateur.name,
      'Email': newRestaurateur.email,
      'PhoneNumber': newRestaurateur.phoneNumber,
      'Password': newRestaurateur.password,
      'Location': newRestaurateur.location,
      'Photo': newRestaurateur.photo,
      'WorkingHours': newRestaurateur.workingHours,
      'WorkingDays': newRestaurateur.workingDays,
      'Description': newRestaurateur.description,
      'RatingValueAverage': newRestaurateur.ratingValueAverage?.toString(),
      'MenuFilePDF': newRestaurateur.menuFilePDF,
      'Categories': newRestaurateur.restaurateurCategories,
      'DietaryPreferences': newRestaurateur.restaurateurPreferences,
      'SpecialFeatures': newRestaurateur.restaurateurSpecialFeatures,
      'Pricing': newRestaurateur.restaurateurPricing,
    });
    return response;
  }

  Future<List<Restaurateur>> getRestaurateurs() async {
    final response = await database.select();
    return (response as List)
        .map((data) => Restaurateur.fromJson(data))
        .toList();
  }

  Future<Restaurateur?> getOneRestaurateur(int restaurateurID) async {
    try {
      final response = await database.select().eq('RestaurateurID', restaurateurID).single();
      return Restaurateur.fromJson(response);
    } catch (e) {
      print('Error fetching restaurateur: $e');
      return null;  
    }
  }

  Future<void> updateRestaurateur(Restaurateur updatedRestaurateur) async {
    final response = await database
      .update(updatedRestaurateur.toJson())
      .eq('RestaurateurID', updatedRestaurateur.restaurateurID!);

    if (response.error != null) {
      throw Exception('Failed to update restaurateur: ${response.error!.message}');
    }
  }

  Future deleteRestaurateur(int restaurateurID) async {
    final response = await database.delete().eq('RestaurateurID', restaurateurID);
    if (response.error != null) {
      print('Error deleting restaurateur: ${response.error!.message}');
      return;
    }
    print('Successfully deleted restaurateur with ID: $restaurateurID');
  }

  final stream = Supabase.instance.client.from('restaurateur').stream(
    primaryKey: ['restaurateurID'],
  );
}
