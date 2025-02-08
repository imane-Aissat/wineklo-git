
import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';

class VerificationWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final TextEditingController verificationCodeController;
  final Function(String) onVerify;
  final Function() onResend;

  const VerificationWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.verificationCodeController,
    required this.onVerify,
    required this.onResend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
          child: TextField(
            controller: verificationCodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter verification code',
              labelStyle: TextStyle(
                fontFamily: 'Sen',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.045,
              color: blackColor,
              ),
              filled: true,
            fillColor: lightGrayColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Center(
          child: TextButton(
            onPressed: onResend,
            child: Text(
              'Didn\'t receive the code? Resend',
                            style: TextStyle(fontSize: 16.0, color: darkOrangeColor, fontFamily: 'Sen'),

            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Center(
          child: SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.07,
            child: ElevatedButton(
              onPressed: () {
                if (verificationCodeController.text.isNotEmpty) {
                  onVerify(verificationCodeController.text);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Invalid Code'),
                        content: const Text('The code you entered is incorrect.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: razprimaryButtonStyle.copyWith(
              minimumSize: WidgetStateProperty.all(Size(screenWidth * 0.8, screenHeight * 0.07)), // Ensure responsive size
              padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: screenHeight * 0.015)), // Responsive padding
            ),
              child: Text(
                'VERIFY',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.05,
                color: whiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}    