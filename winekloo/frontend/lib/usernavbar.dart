import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/bloc/foodie_cubit.dart';
import '/views/themes/styles/colors.dart';
import '/views/screens/homescreen/HomeScreen.dart';
import '/views/screens/homescreen/Search.dart';
import '/views/screens/homescreen/favorites.dart';
import '/views/screens/homescreen/profile.dart';

class UserNavBar extends StatefulWidget {
    const UserNavBar ({super.key});
    @override
    State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {

  int _selectedindex = 0;

  List<Widget> screens = [
    const homeScreen(),
    const SearchPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
        return BlocProvider(
          create: (context) => FoodieCubit(),
          child: Scaffold(
          body: screens[_selectedindex],
          
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.white,
            overlayColor: null,
            indicatorColor: Colors.transparent,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              height: 70,
              elevation: 0,
              selectedIndex: _selectedindex,
                destinations: [
                    NavigationDestination(
                        icon: Icon(
                          Icons.home,
                          color: _selectedindex == 0 ? darkOrangeColor : Colors.grey), 
                          label: ""), //homepage
                    NavigationDestination(
                        icon: Icon(
                          Icons.search,
                          color: _selectedindex == 1 ? darkOrangeColor : Colors.grey), 
                          label: "",), //search page
                    NavigationDestination(
                        icon: Icon(
                          Icons.star,
                          color: _selectedindex == 2 ? darkOrangeColor : Colors.grey), 
                          label: ""), //favorites
                    NavigationDestination(
                        icon: Icon(
                          Icons.account_box_outlined,
                          color: _selectedindex == 3 ? darkOrangeColor : Colors.grey), 
                          label: ""), //profile
                ],
              onDestinationSelected: (index) => {
                setState(() {
                  _selectedindex = index;
                })
              },
            ),
        
        ));
    }
}

