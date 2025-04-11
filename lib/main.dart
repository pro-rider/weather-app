import 'package:flutter/material.dart';
// import 'package:simple_page/profile/discover/discover_page.dart';
// import 'package:simple_page/profile/discover_card.dart/discover_card.dart';
import 'package:simple_page/first_page/navigation/routes.dart';
// import 'package:simple_page/first_page/splash/home_page.dart';
// import 'package:simple_page/first_page/splash/splash_screen.dart';
// import 'package:simple_page/profile/profile/profile_ui.dart';
// import 'package:simple_page/weather/weather_page.dart';
// import 'package:simple_page/weather/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.system,

      // darkTheme: ThemeData(
      //   scaffoldBackgroundColor: AppColors.tdDarkMode,
      // ),
      
      
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // routes: {
      //   '/': (context) =>SplashScreen(),
      //   '/weather': (context) => WeatherPage(),
      //   '/profile': (context) => MyProfilePage(),
      // },

      // home: WeatherPage(),
      // home: MyProfilePage(),
      // home: DiscoverCardWidgets(),
      // home: DiscoverPage(),
      initialRoute: '/news_feed',
      routes: AppRoutes.routes,
    );
  }
}
