import 'package:flutter/material.dart';
import 'package:simple_page/first_page/splash/home_page.dart';
import 'package:simple_page/first_page/splash/splash_screen.dart';
import 'package:simple_page/form_valadation/form/forget_password/page/forget_password_page.dart';
import 'package:simple_page/form_valadation/form/login/page/login_page.dart';
import 'package:simple_page/form_valadation/form/signup/page/sign_up_page.dart';
import 'package:simple_page/profile/discover/discover_page.dart';
import 'package:simple_page/profile/discover_card.dart/discover_card.dart';
import 'package:simple_page/profile/profile/profile_ui.dart';
import 'package:simple_page/user_profile/profile_picture/profile_picture_user.dart';
import 'package:simple_page/weather/weather_page.dart';

class AppRoutes{
  static Map<String, WidgetBuilder> routes = {
        // '/': (context) =>LoginPage(),
        '/': (context) => WeatherPage(),
        // '/': (context) => ProfilePictureUser(),
        '/signup': (context) => SignUpPage(),
        // 'profile_user': (context) => ProfilePictureUser(),
        '/forgetpassword': (context) => ForgetPasswordPage(),
        '/splash': (context) => SplashScreen(),
        // '/weather': (context) => WeatherPage(),
        '/profile': (context) => MyProfilePage(),
        '/home': (context) => HomePage(),
        '/discover': (context) => DiscoverPage(),
        '/profile_ui': (context) => MyProfilePage(),
        '/discover_card': (context) => DiscoverCardWidgets()
    

  };
}


