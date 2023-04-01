import 'package:flutter/material.dart';

class MyTheme {

  static Color primaryColor = Color(0xFF001B48);
  static Color lightBlue = Color(0xFFD6E8EE);
  static Color mediumLightBlue = Color(0xFF97CADB);
  static final ThemeData lightTheme = ThemeData(
      //scaffoldBackgroundColor: Colors.white,
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18)
              )
          )
      ),
      cardColor: Colors.white,
     // accentColor: lightPrimary,
      textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.w500,

          ),
          headline4: TextStyle(
            fontSize: 28,
            color: Colors.black,
          ),
          subtitle2: TextStyle(
              fontSize: 14,
              color: Colors.black
          )
      ),
   //   primaryColor: lightPrimary,
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w500
          ),
          iconTheme: IconThemeData(
              color: Colors.black
          )
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
              size: 36,
              color: Colors.black
          ),
          unselectedIconTheme: IconThemeData(
              size: 24,
              color: Colors.white
          ),
          selectedLabelStyle: TextStyle(
              color: Colors.black
          ),
          selectedItemColor: Colors.black
      )
  );
}