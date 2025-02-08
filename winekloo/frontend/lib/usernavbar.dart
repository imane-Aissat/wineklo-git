import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/bloc/foodie_cubit.dart';
import 'package:userworkside/models/foodie_model.dart';
import '/views/themes/styles/colors.dart';
import '/views/screens/homescreen/HomeScreen.dart';
import '/views/screens/homescreen/Search.dart';
import 'views/screens/homescreen/Favorites.dart';
import 'views/screens/homescreen/Profile.dart';

class UserNavBar extends StatefulWidget {
  const UserNavBar({super.key});

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {
  int _selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodieCubit()..loadProfile(), 
      child: BlocBuilder<FoodieCubit, Foodie?>(
        builder: (context, foodieProfile) {
          if (foodieProfile == null) {
            print("hello");
            return const Center(child: CircularProgressIndicator());
          }

          List<Widget> screens = [
            const Homescreen(),
            const SearchPage(),
            FavoritesPage(foodieID: foodieProfile.foodieID ?? 0),
            const ProfilePage(),
          ];

          return Scaffold(
            body: screens[_selectedindex],
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              height: 70,
              elevation: 0,
              selectedIndex: _selectedindex,
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.home,
                    color: _selectedindex == 0 ? darkOrangeColor : Colors.grey,
                  ),
                  label: "",
                ), // Home
                NavigationDestination(
                  icon: Icon(
                    Icons.search,
                    color: _selectedindex == 1 ? darkOrangeColor : Colors.grey,
                  ),
                  label: "",
                ), // Search
                NavigationDestination(
                  icon: Icon(
                    Icons.star,
                    color: _selectedindex == 2 ? darkOrangeColor : Colors.grey,
                  ),
                  label: "",
                ), // Favorites
                NavigationDestination(
                  icon: Icon(
                    Icons.account_box_outlined,
                    color: _selectedindex == 3 ? darkOrangeColor : Colors.grey,
                  ),
                  label: "",
                ), // Profile
              ],
              onDestinationSelected: (index) {
                setState(() {
                  _selectedindex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
