import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/usernavbar.dart';
import '/views/screens/food_managment/restaunavbar.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/views/widgets/forgotpassword.dart';
import '/views/widgets/login.dart';
import '/bloc/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isLoggedIn) {
            if (state.role == 'foodie') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserNavBar()),
              );
            } else if (state.role == 'restaurateur') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const restoNavBar()),
              );
            }
          } else if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: darkBlueColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    // Dynamic Header
                    Center(
                      child: Text(
                        state.currentState == 'login' ? 'Log In' : 'Forgot Password',
                        style: whiteHeadlineStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Center(
                      child: Text(
                        state.currentState == 'login'
                            ? 'Please sign in to your existing account'
                            : 'Choose how you want to receive your reset code',
                        style: whiteSubheadingStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    // Form
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        padding: const EdgeInsets.all(32.0),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildFormContent(state, context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildFormContent(LoginState state, BuildContext context) {
    switch (state.currentState) {
      case 'forgotPassword':
        return [
          ForgotPasswordWidget(
            screenWidth: MediaQuery.of(context).size.width,
            screenHeight: MediaQuery.of(context).size.height,
            onSendCode: () {
              context.read<LoginCubit>().setCurrentState('login'); // Go back to login instead of verification
            },
          ),
        ];
      default:
        return [
          LoginWidget(
            screenWidth: MediaQuery.of(context).size.width,
            screenHeight: MediaQuery.of(context).size.height,
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            isPasswordVisible: state.isPasswordVisible,
            rememberMe: state.rememberMe,
            onPasswordVisibilityChange: (isVisible) {
              context.read<LoginCubit>().togglePasswordVisibility();
            },
            onRememberMeChange: (value) {
              context.read<LoginCubit>().toggleRememberMe(value);
            },
            onLogin: (email, password) async {
              await context.read<LoginCubit>().login(email, password);
            },
            onForgotPassword: () {
              context.read<LoginCubit>().setCurrentState('forgotPassword');
            },
          ),
        ];
    }
  }
}
