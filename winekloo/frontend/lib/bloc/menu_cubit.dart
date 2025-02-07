import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';

class MenuCubit extends Cubit<List<Menu>> {
  MenuCubit() : super([]);  // Initial state is empty list

  static const String baseUrl = "http://127.0.0.1:5000";  // Change if using a different IP

  Future<void> fetchMenus() async {
  try {
    emit([]);  // Emit empty list to show progress indicator while loading
    final response = await http.get(Uri.parse("$baseUrl/menu"));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Debugging

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Menu> menus = data.map((json) => Menu.fromJson(json)).toList();
      emit(menus);  // Emit the menus list when data is fetched
    } else {
      emit([]);  // Emit empty list if request fails
    }
  } catch (e) {
    print("Error fetching menus: $e");
    emit([]);  // Emit empty list on error
  }
}
  // ✅ Fetch menus by restaurant ID
  Future<void> fetchMenusByRestaurantId(int restaurantId) async {
    try {
      emit([]);  // Show loading state
      final response = await http.get(Uri.parse("$baseUrl/menu/restaurant/$restaurantId"));
      
      print("API Response: ${response.body}"); // Debugging

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Menu> menus = data.map((json) => Menu.fromJson(json)).toList();
        emit(menus);  // Emit the fetched menus list
      } else {
        emit([]);  // Emit empty list if request fails
      }
    } catch (e) {
      print("Error fetching menus by restaurant ID: $e");
      emit([]);  // Emit empty list on error
    }
  }



  // Get menu by ID with loading feedback
  Future<void> getMenuById(int menuID) async {
    try {
      emit([]);  // Show loading state by emitting an empty list
      final response = await http.get(Uri.parse("$baseUrl/menu/$menuID"));
      print("API Response: ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final menu = Menu.fromJson(data);
        print("hello");
        emit([menu]);  // Emit the fetched menu as a list
      } else {
        emit([]);  // Emit empty list if request fails
      }
    } catch (e) {
      print("Error fetching menu: $e");
      emit([]);  // Emit empty list on error
    }
  }

  // Other CRUD methods remain the same (createMenu, updateMenu, deleteMenu)


  // ✅ Create a new menu item
 
  Future<void> createMenu(Menu newItem) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/menu/create"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newItem.toJson()),  // Ensure `toJson()` is correctly implemented in `Menu` model
    );

    print('Create Menu Response: ${response.body}');  // Debugging

    if (response.statusCode == 201) {  // Check the correct status code from your backend
      final newItemFromServer = Menu.fromJson(jsonDecode(response.body));
      emit([...state, newItemFromServer]);  // Update state with the new item
    } else {
      print('Failed to create menu item: ${response.body}');
    }
  } catch (e) {
    print('Error creating menu item: $e');
  }
}


  // ✅ Update an existing menu item
  Future<void> updateMenu(int menuID, Menu updatedMenu) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/menu/$menuID"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedMenu.toJson()),
      );

      if (response.statusCode == 200) {
        fetchMenus();  // Refresh list
      } else {
        print("Error updating menu: ${response.body}");
      }
    } catch (e) {
      print("Error updating menu: $e");
    }
  }

  // ✅ Delete a menu item
  Future<void> deleteMenu(int menuID) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/menu/$menuID"));

      if (response.statusCode == 200) {
        fetchMenus();  // Refresh list
      } else {
        print("Error deleting menu: ${response.body}");
      }
    } catch (e) {
      print("Error deleting menu: $e");
    }
  }
}
