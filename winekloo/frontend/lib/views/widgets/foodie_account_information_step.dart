import 'package:flutter/material.dart';
import '/views/widgets/textField.dart';
import '/views/widgets/passwordField.dart';
import '/views/widgets/phoneField.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/bloc/foodie_signup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInformationStep extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const AccountInformationStep({
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodieSignupCubit, SignupState>(
      builder: (context, state) {
        final cubit = context.read<FoodieSignupCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: "Full Name",
              hintText: "Enter your full name",
              controller: fullNameController,
            ),
            CustomTextField(
              label: "Email",
              hintText: "example@gmail.com",
              controller: emailController,
            ),
            PhoneField(controller: phoneController),
            PasswordField(
              context: context,
              label: "Password",
              obscureText: state.obscurePassword,
              toggleObscure: cubit.togglePasswordVisibility,
              controller: passwordController,
            ),
            PasswordField(
              context: context,
              label: "Confirm Password",
              obscureText: state.obscureConfirmPassword,
              toggleObscure: cubit.toggleConfirmPasswordVisibility,
              controller: confirmPasswordController,
            ),
            Row(
              children: [
                Checkbox(
                  value: state.agreeToTerms,
                  activeColor: darkOrangeColor,
                  onChanged: (value) => cubit.updateAgreeToTerms(value!),
                ),
                GestureDetector(
                  onTap: () => cubit.updateAgreeToTerms(!state.agreeToTerms),
                  child: const Text(
                    'I agree to the terms of service',
                    style: blackBodyTextStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
