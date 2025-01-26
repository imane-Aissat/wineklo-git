// abstractAuthentication.dart
abstract class AbstractAuthentication {
  Future<bool> login(String email, String password);
  Future<void> sendOtp(String identifier); // email or phone
  Future<bool> verifyOtp(String identifier, String otpCode);
}
