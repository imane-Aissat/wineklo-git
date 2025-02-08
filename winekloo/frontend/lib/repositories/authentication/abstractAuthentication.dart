
abstract class AbstractAuthentication {
  Future<bool> login(String email, String password);
  Future<void> sendOtp(String identifier); 
  Future<bool> verifyOtp(String identifier, String otpCode);
}
