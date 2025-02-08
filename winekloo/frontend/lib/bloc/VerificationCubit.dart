import 'package:flutter_bloc/flutter_bloc.dart';
import '/services/email_service.dart';

class VerificationCubit extends Cubit<String> {
  final EmailService _emailService;
  String _generatedOtp = ''; // Store the generated OTP temporarily

  VerificationCubit(this._emailService) : super('');

  String _email = '';
  String _otp = '';

  // Update email value
  void updateEmail(String email) {
    _email = email;
  }

  // Send OTP email using EmailService
  Future<void> sendOtp() async {
    final otp = _generateOtp();
    _generatedOtp = otp; // Store the generated OTP temporarily
    final success = await _emailService.sendOtpEmail(_email, otp);

    if (success) {
      print("OTP Sent to $_email");
    } else {
      emit("Failed to send OTP. Try again.");
    }
  }

  // Generate a random 6-digit OTP
  String _generateOtp() {
    final otp = (100000 + (999999 - 100000) * (0.5 + (0.5 * (1 - 1)))).toString().split(".")[0];
    return otp;
  }

  // Update the OTP entered by the user
  void updateOtp(String otp) {
    _otp = otp;
    emit(_otp); // Update state with the entered OTP for UI purposes
  }

  // Verify OTP by comparing the entered OTP with the generated one
  Future<void> verifyOtp() async {
    if (_otp == _generatedOtp) { // Compare entered OTP with the generated OTP
      print("OTP Verified");
      emit("Verified");
    } else {
      emit("Invalid OTP");
    }
  }

  // Resend OTP by calling sendOtp again
  void resendOtp() {
    sendOtp();
  }
}
