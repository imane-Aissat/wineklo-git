import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuCubit extends Cubit<List<Menu>> {
  MenuCubit() : super([]); 

  static const String baseUrl = "http://127.0.0.1:5000";  
  Future<void> fetchMenus() async {
  try {
    emit([]);  
    final response = await http.get(Uri.parse("$baseUrl/menu"));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); 

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Menu> menus = data.map((json) => Menu.fromJson(json)).toList();
      emit(menus);  
    } else {
      emit([]);  
    }
  } catch (e) {
    print("Error fetching menus: $e");
    emit([]);  
  }
}

  Future<void> fetchMenusByRestaurantId(int restaurantId) async {
    try {
      emit([]);  
      final response = await http.get(Uri.parse("$baseUrl/menu/restaurant/$restaurantId"));

      print("API Response: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Menu> menus = data.map((json) => Menu.fromJson(json)).toList();
        emit(menus);  
      } else {
        emit([]);  
      }
    } catch (e) {
      print("Error fetching menus by restaurant ID: $e");
      emit([]);  
    }
  }
  Future<void> fetchMenuByRestaurantId() async {
    try {
     final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      emit([]);
      return;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/menu/restaurant'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
      print("API Response: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Menu> menus = data.map((json) => Menu.fromJson(json)).toList();
        emit(menus);  
      } else {
        emit([]);  
      }
    } catch (e) {
      print("Error fetching menus by restaurant ID: $e");
      emit([]);  
    }
  }



  Future<void> getMenuById(int menuID) async {
    try {
      emit([]);  
      final response = await http.get(Uri.parse("$baseUrl/menu/$menuID"));
      print("API Response: ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final menu = Menu.fromJson(data);
        print("hello");
        emit([menu]);  
      } else {
        emit([]);  
      }
    } catch (e) {
      print("Error fetching menu: $e");
      emit([]);  
    }
  }




  Future<void> createMenu(Menu newItem) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/menu/create"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newItem.toJson()), 
    );

    print('Create Menu Response: ${response.body}');  

    if (response.statusCode == 201) {  
      final newItemFromServer = Menu.fromJson(jsonDecode(response.body));
      emit([...state, newItemFromServer]);  
    } else {
      print('Failed to create menu item: ${response.body}');
    }
  } catch (e) {
    print('Error creating menu item: $e');
  }
}

Future<void> updateMenu(Menu updatedMenu) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl/menu/update/${updatedMenu.menuID}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updatedMenu.toJson()),
    );
    if (response.statusCode == 200) {
      final updatedList = state.map((menu) => menu.menuID == updatedMenu.menuID ? updatedMenu : menu).toList();
      emit(updatedList); 
    } else {
      print("Error updating menu: ${response.body}");
    }
  } catch (e) {
    print("Error updating menu: $e");
  }
}

Future<void> deleteMenu(int menuID) async {
  try {
    final response = await http.delete(Uri.parse("$baseUrl/menu/delete/$menuID"));
      if (response.statusCode == 200) {
      final updatedList = state.where((menu) => menu.menuID != menuID).toList();
      emit(updatedList);  
    } else {
      print("Error deleting menu: ${response.body}");
    }
  } catch (e) {
    print("Error deleting menu: $e");
  }
}
}