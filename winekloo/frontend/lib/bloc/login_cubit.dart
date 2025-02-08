import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../models/foodie_model.dart';
import '../models/restaurateur_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState {
  final bool isPasswordVisible;
  final bool rememberMe;
  final String currentState;
  final String errorMessage;
  final bool isLoading;
  final bool isLoggedIn;
  final String? role;
  final int? userID;

  LoginState({
    required this.isPasswordVisible,
    required this.rememberMe,
    required this.currentState,
    required this.errorMessage,
    required this.isLoading,
    required this.isLoggedIn,
    this.role,
    this.userID,
  });

  LoginState copyWith({
    bool? isPasswordVisible,
    bool? rememberMe,
    String? currentState,
    String? errorMessage,
    bool? isLoading,
    bool? isLoggedIn,
    String? role,
    int? userID,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      rememberMe: rememberMe ?? this.rememberMe,
      currentState: currentState ?? this.currentState,
      errorMessage: errorMessage ?? '',
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      role: role ?? this.role,
      userID: userID ?? this.userID,
    );
  }
}

class LoginCubit extends Cubit<LoginState> {
  static const String baseUrl = "http://127.0.0.1:5000";

  LoginCubit()
      : super(LoginState(
          isPasswordVisible: false,
          rememberMe: false,
          currentState: 'login',
          errorMessage: '',
          isLoading: false,
          isLoggedIn: false,
        ));

  String? sessionCookie;
  Future<void> login(String email, String password) async {

    emit(state.copyWith(isLoading: true, errorMessage: '', isLoggedIn: false, role: null, userID: null));
    try {
      // Check if user exists in Foodie table
      final foodieResponse = await http.post(
              Uri.parse("$baseUrl/foodie/login"),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode({"email": email, "password": password}),
            );

      if (foodieResponse.statusCode == 200) {
        final data = jsonDecode(foodieResponse.body);
        final token = data["token"];
        final foodie = Foodie.fromJson(data["foodie"]);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
          emit(state.copyWith(isLoading: false, isLoggedIn: true, role: 'foodie', userID: foodie.foodieID));
          return;
      }


      // If not found in Foodie, check in Restaurateur table
      final restaurateurResponse = await http.post(
        Uri.parse("$baseUrl/restaurateur/login"),
        headers: {"Content-Type": "application/json",
                  'Cookie': 'session_cookie=$sessionCookie',},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (restaurateurResponse.statusCode == 200) {
        final data = jsonDecode(restaurateurResponse.body);
        final restaurateur = Restaurateur.fromJson(data);
        emit(state.copyWith(isLoading: false, isLoggedIn: true, role: 'restaurateur', userID: restaurateur.restaurateurID));
        return;
      }

      emit(state.copyWith(isLoading: false, errorMessage: 'Invalid email or password', isLoggedIn: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error: $e', isLoggedIn: false));
    }
  }
    Future<void> checkLogin() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        emit(state.copyWith(isLoggedIn: false));
        return;
      }

      final response = await http.get(
        Uri.parse("$baseUrl/foodie/logged"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final foodie = Foodie.fromJson(data);
        emit(state.copyWith(isLoggedIn: true, userID: foodie.foodieID));
      } else {
        emit(state.copyWith(isLoggedIn: false));
      }
    }

    Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
      emit(state.copyWith(isLoggedIn: false));
    }
  
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  void setCurrentState(String newState) {
    emit(state.copyWith(currentState: newState));
  }


}

