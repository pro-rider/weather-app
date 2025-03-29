import 'package:flutter/material.dart';
import 'package:simple_page/profile/widgets/custom_rounded_button_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 100, // Adjust the radius for logo size
            backgroundImage: AssetImage('assets/images/logo_final2.jpeg'),
          ),
          const SizedBox(height: 20), // Space between logo and buttons
          CustomRoundedButton(
            label: "Weather",
            onPressed: () {
              //connect routes
              // Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherPage()));
              //named routes
              Navigator.pushNamed(context, '/weather');
            },
          ),
          const SizedBox(height: 10), // Space between buttons
          CustomRoundedButton(
            label: "Profile",
            onPressed: () {
              //connect routes
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage()));
              // named routes
              Navigator.pushNamed(context, '/profile');
            },
            
          ),
          const SizedBox(height: 10), // Space between buttons
          CustomRoundedButton(
            label: "Discover",
            onPressed: () {
              //connect routes
              // Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherPage()));
              //named routes
              Navigator.pushNamed(context, '/discover');
            },
          ),
          const SizedBox(height: 10), // Space between buttons
          CustomRoundedButton(
            label: "DiscoverCard",
            onPressed: () {
              //connect routes
              // Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherPage()));
              //named routes
              Navigator.pushNamed(context, '/discover_card');
            },
          ),
        ],
      ),
    );
  }
}
