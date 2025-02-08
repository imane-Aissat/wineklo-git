import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/bloc/categories_cubit.dart';
import 'package:userworkside/bloc/dietarypreferences_cubit.dart';
import 'package:userworkside/bloc/menu_cubit.dart';
import 'package:userworkside/bloc/specialfeatures_cubit.dart';

import '/views/screens/food_managment/restaunavbar.dart';
import '/views/screens/homescreen/HomeScreen.dart';
import '/views/screens/onBoarding/onBoardingPage.dart';
import '/views/screens/signup/signupPage.dart';
import 'bloc/foodie_signup_cubit.dart';
import 'commons/config.dart';
import 'views/screens/login/loginPage.dart';
import 'views/screens/onBoarding/AnimatedSplash.dart';
import 'views/screens/signup/foodieSignup.dart';
import 'views/themes/styles/theme.dart';
import '/bloc/login_cubit.dart';
import '/bloc/role_cubit.dart';
import '../../../bloc/foodie_cubit.dart';
import 'package:userworkside/bloc/restaurateurs_cubit.dart';
import 'package:userworkside/bloc/reviews_cubit.dart';
import 'package:userworkside/usernavbar.dart'; 


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
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
        BlocProvider<RoleCubit>(create: (_) => RoleCubit()),
        BlocProvider<FoodieSignupCubit>(create: (_) => FoodieSignupCubit()),
        
        BlocProvider<FoodieCubit>(
        create: (context) {
          final cubit = FoodieCubit();
          cubit.loadProfile();  
          return cubit;
          },
        ),
        BlocProvider<RestaurateursCubit>(create: (_) => RestaurateursCubit()),
        BlocProvider<ReviewsCubit>(create: (_) => ReviewsCubit()),
        BlocProvider<SpecialFeaturesCubit>(create: (_) => SpecialFeaturesCubit()),
        BlocProvider<CategoriesCubit>(create: (_) => CategoriesCubit()),
        BlocProvider<DietaryPreferencesCubit>(create: (_) => DietaryPreferencesCubit()),
        BlocProvider<MenuCubit>(create: (_) => MenuCubit()),
      ],
      child: MaterialApp(

      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: THEME_DATA,
      initialRoute: '/FoodieSignupPage',
      routes: {
        '/': (context) => const LoginPage(),
        '/splash': (context) => const AnimatedSplashScreen(),
        '/onboarding': (context) => const OnboardingPage(),  
        '/home': (context) => const Homescreen(),
        '/homeRestau': (context) =>  const restoNavBar(),
        '/usernavbar': (context) => const UserNavBar(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/FoodieSignupPage': (context) => const FoodieSignupPage(),
      },
    ),
    );
  }
}