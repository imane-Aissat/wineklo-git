import 'package:flutter/material.dart';
import '/views/widgets/textField.dart';
import '/views/widgets/passwordField.dart';
import '/views/widgets/diningType_dropdown.dart';

import '/views/widgets/phoneField.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/bloc/restaurateur_signup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInformationStep extends StatelessWidget {
  final TextEditingController businessNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const AccountInformationStep({
    required this.businessNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurateurSignupCubit, SignupState>(
      builder: (context, state) {
        final cubit = context.read<RestaurateurSignupCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DiningTypeDropdown(
              selectedDiningType: state.selectedDiningType,
              onChanged: (value) {
                cubit.updateDiningType(value);
              },
            ),
      
            CustomTextField(
              label: "Business Name",
              hintText: "Enter your business name",
              controller: businessNameController,
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
