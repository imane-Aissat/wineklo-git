import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailService {
  final String username = dotenv.env['SMTP_USERNAME'] ?? 'default_email@example.com';
  final String smtpPassword = dotenv.env['SMTP_PASSWORD'] ?? 'default_value';

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  Future<bool> sendOtpEmail(String recipientEmail, String otp) async {
    if (!isValidEmail(recipientEmail)) {
      print("Invalid email address");
      return false;
    }

    final smtpServer = gmail(username, smtpPassword);

    final message = Message()
      ..from = Address(username, 'WINEKLO App')
      ..recipients.add(recipientEmail)
      ..subject = 'Your OTP Code'
      ..text = 'Your OTP code is: $otp';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
      return true;
    } on MailerException catch (e) {
      print('Message not sent. Error: $e');
      return false;
    }
  }
}
