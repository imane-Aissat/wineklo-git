import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';

final THEME_DATA = ThemeData(

  useMaterial3: true, // Material Design 3 styling.
  primaryColor: lightOrangeColor, //the primary color of the app.
  scaffoldBackgroundColor: whiteColor, //the default background color for Scaffold.

  drawerTheme: const DrawerThemeData(
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.zero, // no rounding for the drawer's shape.
    ),
  ),
);
