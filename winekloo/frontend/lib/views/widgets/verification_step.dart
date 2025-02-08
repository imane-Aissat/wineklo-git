import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/VerificationCubit.dart';
import '/services/email_service.dart';

class VerificationStep extends StatelessWidget {
  final String email;

  VerificationStep({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => VerificationCubit(EmailService())..updateEmail(email), 
      child: BlocBuilder<VerificationCubit, String>(
        builder: (context, state) {
          final cubit = context.read<VerificationCubit>();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                child: Center(
                  child: Text(
                    state.isNotEmpty && state != "Verified"
                        ? state
                        : 'A code has been sent to $email',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: cubit.resendOtp,
                child: Center(
                  child: Text(
                    'Resend code',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.04,
                      color: Colors.orange,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: cubit.updateOtp,
                  decoration: InputDecoration(
                    labelText: 'Enter verification code',
                    labelStyle: TextStyle(
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: cubit.verifyOtp,
                child: Text("Verify Code"),
              ),
            ],
          );
        },
      ),
    );
  }
}
