import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/models/foodie_model.dart';
import 'package:userworkside/views/screens/homescreen/Favorites.dart';
import '/themes/styles/colors.dart';
import '/themes/styles/styles.dart';
import '/views/screens/homescreen/editProfile.dart';
import '/views/screens/homescreen/settingsPage.dart';
import '../../../bloc/foodie_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => FoodieCubit()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile',
            style: blackSubHeadlineStyle.copyWith(fontSize: screenWidth * 0.05),
          ),
          backgroundColor: whiteColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: blackColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: whiteColor,
        body: BlocBuilder<FoodieCubit, Foodie?>(
          builder: (context, foodieProfile) {
            if (foodieProfile == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.2,
                            height: screenWidth * 0.2,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: foodieProfile.photo != null &&
                                      foodieProfile.photo!.isNotEmpty
                                  ? AssetImage(foodieProfile.photo!)
                                  : const AssetImage(
                                          "assets/images/defaultprofilepic.jpg")
                                      as ImageProvider,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            foodieProfile.fullname ?? "Unnamed User",
                            style: blackSubHeadlineStyle,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          SizedBox(
                            width: screenWidth * 0.35,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              style: primaryButtonStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfile(foodieID: foodieProfile.foodieID ?? 0),
                                  ),
                                );
                              },
                              child: const Text(
                                "Edit profile",
                                style: whiteSubheadingStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.03),
                    child: Row(
                      children: [
                        const Text(
                          "Favorites",
                          style: blackSubHeadlineStyle,
                        ),
                        SizedBox(width: screenWidth * 0.55),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                   
                   Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritesPage(foodieID: foodieProfile.foodieID ?? 0)),
                            );
                        },
                        
                        style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                        backgroundColor: lightOrangeColor,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        shadowColor: darkOrangeColor,
                        elevation: 4.0,
                        ),
                        child: const Text("Check out all your favorites from here!!" , style: whiteSubheadingStyle),),
                    ),
                  
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
