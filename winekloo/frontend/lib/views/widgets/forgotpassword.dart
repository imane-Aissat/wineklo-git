import 'package:flutter/material.dart';
import '/views/themes/styles/styles.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onSendCode; // Callback to trigger state change

  const ForgotPasswordWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onSendCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter your email or phone number to reset your password',
          style: blackBodyTextStyle,
        ),
        SizedBox(height: screenHeight * 0.03),
        
        // Email input field
        _buildEmailInputField(),

        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          width: screenWidth * 0.8,
          child: ElevatedButton(
            style: razprimaryButtonStyle,
            onPressed: onSendCode, // Trigger the parent callback
            child: const Text('SEND CODE'),
          ),
        ),
      ],
    );
  }

  // Email input field
  Widget _buildEmailInputField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Enter your email or phone number',
        border: OutlineInputBorder(),
        hintText: 'Email or Phone',
      ),
    );
  }
}
