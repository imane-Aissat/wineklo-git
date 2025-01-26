import 'package:flutter/material.dart';
import '/views/screens/food_managment/my_food_list.dart';
import '/views/screens/food_managment/my_reviews.dart';
import '/views/screens/food_managment/resto_profile.dart';
import '/views/screens/food_managment/home.dart';

import '/views/themes/styles/colors.dart';

class restoNavBar extends StatefulWidget {
    const restoNavBar ({super.key});
    @override
    State<restoNavBar> createState() => _restoNavBarState();
}

class _restoNavBarState extends State<restoNavBar> {

  int _selectedindex = 0;

  List<Widget> screens = [
 
  
  const RestaurantDashboardApp(), 
  ReviewsPage(),
  const FoodMenuPage(), 
  const RestaurantViewPage(), 

];


  @override
  Widget build(BuildContext context) {
        return Scaffold(
          
          body: screens[_selectedindex],
          bottomNavigationBar: NavigationBar(
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
                        label: ""),
                        NavigationDestination(
                        icon: Icon(
                          Icons.star,
                          color: _selectedindex == 1 ? darkOrangeColor : Colors.grey), 
                        label: ""), 

                    NavigationDestination(
                        icon: Icon(
                          Icons.menu_book,
                          color: _selectedindex == 2 ? darkOrangeColor : Colors.grey), 
                        label: "",), 
                    
                    NavigationDestination(
                        icon: Icon(
                          Icons.account_box_outlined,
                          color: _selectedindex == 3 ? darkOrangeColor : Colors.grey), 
                        label: ""), 
                ],
              onDestinationSelected: (index) => {
                setState(() {
                  _selectedindex = index;
                })
              },
            ),
        );
    }
}

