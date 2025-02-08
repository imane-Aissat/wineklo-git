import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/views/screens/homescreen/PrivacySettings.dart';
import 'package:userworkside/views/screens/homescreen/ResetPassword.dart';
import '/views/screens/login/loginPage.dart';
import '/views/screens/signup/foodieSignup.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/views/screens/homescreen/editProfile.dart';
import 'Help&Support.dart';
import '../../../bloc/foodie_cubit.dart';
import 'package:userworkside/models/foodie_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

     return BlocProvider(
      create: (context) => FoodieCubit()..loadProfile(),
      child: Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Settings', 
            style: blackSubHeadlineStyle.copyWith(fontSize: screenWidth * 0.05,),
          ),
          backgroundColor: whiteColor,
        ),
       
      body: BlocBuilder<FoodieCubit, Foodie?>(
          builder: (context, foodieProfile) {
            if (foodieProfile == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Container(
              height: screenHeight * 0.12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.08,
                    backgroundColor: lightGrayColor,
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foodieProfile.fullname ?? "Unnamed User",
                        style: blackBodyTextStyle.copyWith(
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      Text(
                        foodieProfile.email ?? "Unnamed User",
                        style: grayBodyTextStyle.copyWith(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: Text(
                "Settings",
                style: blackSubHeadlineStyle.copyWith(
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            ...settingsPossible(context, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.06,
                child: ElevatedButton(
              
                onPressed: () {
                  BlocProvider.of<FoodieCubit>(context).logout();
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage()));
                }, 
              style: primaryButtonStyle,
              child: const Text('Log out', style: buttonTextStyle,)),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Center(
              child: SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (_) => AlertDialog(
                    title: const Text("Delete Account", style: blackSubHeadlineStyle,),
                    content: const Text("Are you sure you want to delete your account ?"),
                    actions: [
                      ElevatedButton(
                        onPressed: ()  {Navigator.pop(context);},
                        style: primaryButtonStyle,
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: ()  {
                           context.read<FoodieCubit>().deleteProfile();
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> const FoodieSignupPage())
                            );
                          },
                        style: primaryDeleteStyle,
                        child: const Text('Delete')
                      ),
                    ],
                  )); 
                }, 
              style: primaryDeleteStyle,
              child: const Text('Delete your account', style: buttonTextStyle,)),
              ),
            ),
          ],
        ),
      );}
  )));
  }

  List<Widget> settingsPossible(BuildContext context, double screenWidth, double screenHeight) {
    final List<Map<String, dynamic>> options = [
      {'icon': Icons.settings , 'title': 'Profile settings', 'action': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile(foodieID: 1,)))},
      {'icon': Icons.lock, 'title': 'Reset password', 'action': () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const ResetPassword()))},
      {'icon': Icons.privacy_tip, 'title': 'Privacy settings', 'action': () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const privacySettings()))},
      {'icon': Icons.help, 'title': 'Help & Support', 'action': () { Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpPage()));}},
    ];
    
    return options
        .map(
          (option) => InkWell(
            onTap: option['action'],
            child: Container(
              decoration: cardDecoration,
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.1),
              height: screenHeight * 0.08,
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.05),
                  Icon(option['icon'], size: screenWidth * 0.07, color: darkOrangeColor ),
                  SizedBox(width: screenWidth * 0.05),
                  Text(
                    option['title'],
                    style: blackSubHeadlineStyle.copyWith(
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  const Spacer(),
                  //Icon(Icons.arrow_right, size: screenWidth * 0.06),
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}
