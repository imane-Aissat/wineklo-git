import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
import '/views/screens/signup/signupPage.dart';

import '/bloc/login_cubit.dart';
import '/bloc/role_cubit.dart';

import '/views/screens/homescreen/HomeScreen.dart';

import '/views/screens/signup/restauSignup.dart';
import '/views/screens/food_managment/restaunavbar.dart';
import '../../../bloc/foodie_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/bloc/restaurateurs_cubit.dart';
import 'package:userworkside/bloc/reviews_cubit.dart';
import 'package:userworkside/usernavbar.dart'; 
/*
void main() async {

  //WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load();
  //await Supabase.initialize(
    //url: 'https://grngcgspcdqsoainkmdh.supabase.co',
   // anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdybmdjZ3NwY2Rxc29haW5rbWRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ5NTAyNTQsImV4cCI6MjA1MDUyNjI1NH0.fy8onyDnoeCSAQ6Dww5qvXF7GsDXG-s51iEewu8KECk',
  //);

  final FoodieRepository foodieRepository = FoodieRepository(); 
  final RestaurateurRepository restaurateurRepository = RestaurateurRepository(); 
 // runApp( const MainApp(/*foodieRepository: foodieRepository, restaurateurRepository: restaurateurRepository,*/));

*/


void main() async {
  runApp(
     const MainApp(),
  );
}

class MainApp extends StatelessWidget {
   // final FoodieRepository foodieRepository;
    //final RestaurateurRepository restaurateurRepository;

 // const MainApp({super.key, required this.foodieRepository, required this.restaurateurRepository});
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
        BlocProvider<RoleCubit>(create: (_) => RoleCubit()),
        BlocProvider<FoodieSignupCubit>(create: (_) => FoodieSignupCubit()),
        
        BlocProvider<FoodieCubit>(create: (_) => FoodieCubit()),
        BlocProvider<RestaurateursCubit>(create: (_) => RestaurateursCubit()),
        BlocProvider<ReviewsCubit>(create: (_) => ReviewsCubit()),
        //BlocProvider<RestaurateurSignupCubit>(create: (_) => RestaurateurSignupCubit(restaurateurRepository: restaurateurRepository)),

       // BlocProvider(create: (_) => VerificationCubit(EmailService()),),

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
        '/home': (context) => const homeScreen(),
        '/homeRestau': (context) =>  const restoNavBar(),
        '/usernavbar': (context) => const UserNavBar(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/FoodieSignupPage': (context) =>  FoodieSignupPage(),
       // '/RestauSignupPage': (context) =>  RestauSignupPage(restaurateurRepository: restaurateurRepository),
      },
    ),
    );
  }
}