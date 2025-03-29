
import 'package:flutter/material.dart';

class AppColors {
  static const Color tdRed = Color(0xFFDA4040);
  static const Color tdBlue = Color(0xFF5F52EE);
  static const Color tdBlack = Color(0xFF3A3A3A);
  static const Color tdGrey = Color(0xFF717171);
  static const Color tdBGColor = Color(0xFFEEEFF5);
  static const Color tdBlue1 = Color(0xFF50C0F8);
  static const Color tdGreen = Color(0xFF46C050);
  static const Color tdYellow = Color(0xFFFFD54F);
  static const Color tdOrange = Color(0xFFF07A36);
  static const Color tdPurple = Color(0xFF8553D8);
  static const Color tdPink = Color(0xFFD593D5);
  static const Color tdLightGrey = Color(0xFFF5F5F5);
  static const Color tdDarkGrey = Color(0xFF9B9B9B);
  static const Color tdDarkMode = Color(0xFF121212);
  static const Color tdWhite = Color(0xFFFFFFFF);
  static const Color tdDarkBlue3 = Color.fromARGB(51, 10, 37, 241);
  static const Color tdRed1 = Color.fromRGBO(255, 82, 82, 1);
  static const Color tdTransparent = Color(0xFFFFFFFF);
  static const Color tdPurplex = Color(0xFFE100FF);
  static const Color tdPurple1 = Color(0xFF7F00FF);
  static const Color tdDarkBackground = Color(0xFF2E2E2E);
  static const Color tdBlue2 = Color(0xFF6dd5ed);
  static const Color tdBorder = Color.fromARGB(255, 221, 92, 92);
  

  /**
    // Dynamic Colors based on Theme Mode
  static Color backgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? tdDarkMode
        : tdBGColor;
  }

  static Color textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? tdWhite : tdBlack;
  }

  static Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? tdGrey : tdBorder;
  }

  static Color errorColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? tdRed1 : tdRed;
  }
  
  */
}
