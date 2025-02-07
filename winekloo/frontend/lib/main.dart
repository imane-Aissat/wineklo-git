import 'package:flutter/material.dart';
import 'package:userworkside/bloc/restaurateurs_cubit.dart';
import 'package:userworkside/bloc/reviews_cubit.dart';
import 'package:userworkside/usernavbar.dart'; 
import '/views/screens/onBoarding/onBoardingPage.dart';
import 'views/themes/styles/theme.dart';
import 'commons/config.dart';          
import '/views/screens/homescreen/HomeScreen.dart';
import 'views/screens/login/loginPage.dart';
import 'views/screens/onBoarding/AnimatedSplash.dart';
import '/views/screens/signup/signupPage.dart';
import '/views/screens/signup/foodieSignup.dart';
import '/views/screens/signup/restauSignup.dart';
import '/views/screens/food_managment/restaunavbar.dart';
import '../../../bloc/foodie_cubit.dart';
import '../../../bloc/menu_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(
     const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
      providers: [
        BlocProvider<FoodieCubit>(create: (_) => FoodieCubit()),
        BlocProvider<MenuCubit>(create: (_) => MenuCubit()),

        BlocProvider<RestaurateursCubit>(create: (_) => RestaurateursCubit()),
        BlocProvider<ReviewsCubit>(create: (_) => ReviewsCubit()),
      ],
      child: MaterialApp(

      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: THEME_DATA,
      initialRoute: '/',
      routes: {
        '/': (context) => const UserNavBar(),
        '/splash': (context) => const AnimatedSplashScreen(),
        '/onboarding': (context) => const OnboardingPage(),
        '/home': (context) => const homeScreen(),
        '/homeRestau': (context) => const restoNavBar(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/FoodieSignupPage': (context) => const FoodieSignupPage(),
        '/RestauSignupPage': (context) => const RestauSignupPage(),
      }, 
    ),
    );
  }
}
