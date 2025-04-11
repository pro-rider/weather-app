import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_page/colors/color_widgets.dart';

/**

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
 */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushNamed(context, '/HomePage()');
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/splash_pic.jpg",
            fit: BoxFit.cover,
            width: width * 0.9,
            height: height * 0.5,
          ),
          SizedBox(height: height * 0.04),
          Text(
            "Top_Head_Lines",
            style: GoogleFonts.anton(
              letterSpacing: .6,
              color: AppColors.tdGrey,
            ),
          ),
          SizedBox(height: height * 0.04),
          SpinKitChasingDots(
            color: AppColors.tdBlue1,
            size: 35,
          ),
        ],
      ),
    ));
  }
}
