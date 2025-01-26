import 'package:flutter/material.dart';
import '/repo/authentication/loginAuthentication.dart';
import '/usernavbar.dart';
import '/views/screens/food_managment/restaunavbar.dart';

import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  String _currentState = 'login';
  String _otpMethod = 'email';
  final LoginAuthentication _auth = LoginAuthentication();
  final TextEditingController _emailController = TextEditingController();
      final TextEditingController verificationCodeController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

String _errorMessage = '';

final bool _isLoading = false;

Future<void> _handleLogin() async {
  print('Attempting login...');
  setState(() {
    _errorMessage = '';
  });

  try {
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    Map<String, dynamic> loginResponse = await _auth.login(
      _emailController.text,
      _passwordController.text,
    );

    if (loginResponse['isLoggedIn']) {
      print('Login successful: ${loginResponse['role']}');
      if (loginResponse['role'] == 'foodie') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserNavBar()),
        );
      } else if (loginResponse['role'] == 'restaurant') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const restoNavBar()),
        );
      }
    }
  } catch (e) {
    print('Login failed: $e');
    setState(() {
      _errorMessage = 'Invalid email or password';
    });
  }
}





  
@override
Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


  return Scaffold(
    body: Stack(
      children: [

        Container(
          decoration: const BoxDecoration(
            color: darkBlueColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:screenHeight * 0.1),
              // Dynamic Header
              Center(
                child: Text(
                  _currentState == 'login'
                      ? 'Log In'
                      : _currentState == 'forgotPassword'
                          ? 'Forgot Password'
                          : 'Verification',
                  style: whiteHeadlineStyle,
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(height: screenHeight * 0.05),
              Center(
                child: Text(
                  _currentState == 'login'
                      ? 'Please sign in to your existing account'
                      : _currentState == 'forgotPassword'
                          ? 'Choose how you want to receive your code'
                          : 'Enter the verification code sent to your ${_otpMethod == 'email' ? "email" : "phone number"}',
                  style: whiteSubheadingStyle,
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(height: screenHeight * 0.05),

              // Form
              Expanded(
                child: Container(
                  height: screenHeight * 0.9,
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
                      children: _buildFormContent(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Back button positioned at the top-left corner
        if (_currentState == 'forgotPassword')
          Positioned(
            top: 40.0, // Adjust the position from the top
            left: 16.0, // Adjust the position from the left
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentState = 'login'; // Switch back to login state
                });
              },
              child: const CircleAvatar(
                backgroundColor: lightGrayColor,
                radius: 20.0,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: darkGrayColor,
                  size: 18.0,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

@override
List<Widget> _buildFormContent() {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  switch (_currentState) {
    case 'forgotPassword':
      return [
        const Text(
          'Select Verification Method',
          style: blackBodyTextStyle,
        ),
        SizedBox(height: screenHeight * 0.03), // Reduced height
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _otpMethod = 'email';
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    color: _otpMethod == 'email' ? lightOrangeColor : lightGrayColor,
                    border: Border.all(
                      color: _otpMethod == 'email' ? Colors.transparent : lightGrayColor,
                      width: screenWidth * 0.005,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: _otpMethod == 'email' ? whiteColor : darkGrayColor,
                        size: screenWidth * 0.08,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'Email',
                        style: blackBodyTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02), // Reduced width
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _otpMethod = 'phone number';
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    color: _otpMethod == 'phone number' ? lightOrangeColor : lightGrayColor,
                    border: Border.all(
                      color: _otpMethod == 'phone number' ? Colors.transparent : lightGrayColor,
                      width: screenWidth * 0.005,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: _otpMethod == 'phone number' ? whiteColor : darkGrayColor,
                        size: screenWidth * 0.08,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'Phone Number',
                        style: blackBodyTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01), // Reduced height
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _otpMethod == 'email' ? 'Email Address' : 'Phone Number',
                style: blackBodyTextStyle,
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  if (_otpMethod == 'phone number') // Only render this field if 'phone number' is selected
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightGrayColor,
                          hintText: 'Enter your phone number',
                          hintStyle: grayBodyTextStyle,
                          
                        
                          prefixIcon:Row(
  children: [
  SizedBox(
  width: screenWidth * 0.16, // Adjust width for flag and prefix
  child: Row(
    mainAxisSize: MainAxisSize.min, // Ensures the row takes up only the required width
    children: [
       SizedBox(width: screenWidth * 0.01 ), // Spacing between flag and prefix
      Image.asset(
        'assets/icons/algeria.png', // Correct the path
        width: screenWidth * 0.04, // Responsive width
        height: screenHeight * 0.035, // Responsive height
        fit: BoxFit.contain,
      ),
       SizedBox(width: screenWidth * 0.01 ), // Spacing between flag and prefix
      Flexible(  // Ensure the prefix doesn't overflow
        child: Text(
          '+213',
          style: TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.w400,
            fontSize: screenWidth * 0.04, // Adjusted font size
            color: darkGrayColor,
          ),
        ),
      ),
    ],
  ),
),

    const VerticalDivider(
      thickness: 1,
      color: darkGrayColor,
    ),
    Expanded(
      // Phone number input field
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: lightGrayColor,
          hintText: 'Enter your phone number',
          hintStyle: grayBodyTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            //horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.015,
          ),
        ),
        keyboardType: TextInputType.phone,
      ),
    ),
  ],
),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.015,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  // This section is for the email input
                  if (_otpMethod == 'email') // Render only if email method is selected
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightGrayColor,
                          hintText: 'example@gmail.com',
                          hintStyle: grayBodyTextStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03, // Reduced padding
                            vertical: screenHeight * 0.01, // Reduced padding
                          ),
                        ),
                        style: grayBodyTextStyle,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
      SizedBox(
  width: screenWidth * 0.8,  // Makes the button responsive by adjusting width based on screen size
  child: ElevatedButton(
    style: razprimaryButtonStyle.copyWith(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          vertical: screenHeight * 0.015, // Dynamic vertical padding
        ),
      ),
      minimumSize: WidgetStateProperty.all(
        Size(screenWidth * 0.8, screenHeight * 0.08),  // Ensures a fixed height with a responsive width
      ),
    ),
    onPressed: () {
      setState(() {
        _currentState = 'verification';
      });
    },
    child: FittedBox(
      fit: BoxFit.scaleDown,  // Ensures the text fits inside the button and scales down if needed
      child: Text(
        'SEND CODE',
        style: TextStyle(
          fontFamily: 'Sen',
          fontWeight: FontWeight.w600,
          fontSize: screenWidth * 0.05,  // Dynamically adjusts the font size based on screen width
          color: whiteColor,
        ),
        textAlign: TextAlign.center,  // Centers the text within the button
      ),
    ),
  ),
),

      ];


      case 'verification':
        return [
          // Code Input Field
       Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
        child: TextField(
          controller: verificationCodeController, // Use controller for input

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
              onPressed: () {
              },
              child: const Text(
                'Didn\'t receive the code? Resend',
                style: TextStyle(fontSize: 16.0, color: darkOrangeColor, fontFamily: 'Sen'),
              ),
            ),
          ),
      
         Center(
        child: SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.07, 
          child: ElevatedButton(
              onPressed: () async {
                if (verificationCodeController.text == '1234') { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserNavBar()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Invalid Code'),
                        content: const Text('The code you entered is incorrect.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
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
        ];
      default:
        // Default is the Login Form
        return [
          // Email Input
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email Address',
                  style: blackBodyTextStyle,
                ),
                SizedBox(height:screenHeight * 0.02),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightGrayColor,
                    hintText: 'example@gmail.com',
                    hintStyle: grayBodyTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  style: grayBodyTextStyle,
                ),
              ],
            ),
          ),
           SizedBox(height: screenHeight * 0.02),

          // Password Input
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Password',
                  style: blackBodyTextStyle,
                ),
                 SizedBox(height:screenHeight * 0.02),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightGrayColor,
                    hintText: 'Enter your password',
                    hintStyle: grayBodyTextStyle,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: darkGrayColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  style: grayBodyTextStyle,
                ),
              ],
            ),
          ),
         SizedBox(height:screenHeight * 0.02),

// Forgot Password and Remember Me Row
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Remember Me section
    Row(
      
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value!;
            });
          },
          activeColor: darkOrangeColor,
          
        ),
        Text(
          'Remember me',
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: screenWidth * 0.035, // Reduced font size
            color: darkGrayColor, // Adjust color if necessary
          ),
        ),
      ],
    ),
    // Forgot Password section
    TextButton(
      onPressed: () {
        setState(() {
          _currentState = 'forgotPassword'; // Transition to forgotPassword
        });
      },
      child:  Text(
        'Forgot Password',
        style: TextStyle(
          fontFamily: 'Sen',
          fontSize: screenWidth * 0.035,  // Reduced font size for better spacing
          color: darkOrangeColor,
        ),
      ),
    ),
  ],
),

           SizedBox(height: screenHeight * 0.02),


          // Login Button
       SizedBox(
  width: screenWidth * 0.8,  // Make the button width responsive
  child: ElevatedButton(
    style: razprimaryButtonStyle.copyWith(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          vertical: screenHeight * 0.015, // Dynamic vertical padding
        ),
      ),
      minimumSize: WidgetStateProperty.all(
        Size(screenWidth * 0.8, screenHeight * 0.08),  // Fixed button height with responsive width
      ),
    ),
onPressed: () async {
  print('Button pressed');
  await _handleLogin();
},
    child: Text(
      'LOG IN',
      style: TextStyle(
        fontFamily: 'Sen',
        fontWeight: FontWeight.w600,
        fontSize: screenWidth * 0.045,  // Responsive text size based on screen width
        color: whiteColor,
      ),
    ),
  ),
),
SizedBox(height: screenHeight * 0.02),  // Spacing between elements

   // Signup Link
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Are you new here?',
                  style: grayBodyTextStyle,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: darkOrangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sen',
                    ),
                  ),
                ),
              ],
            ),
          ),
      ];
    }
  }
}