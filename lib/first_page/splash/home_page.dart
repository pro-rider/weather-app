import 'package:flutter/material.dart';
import 'package:simple_page/profile/discover_card.dart/discover_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the Home Page!'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverCardWidgets()));
              },
              child: Text('Go to Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}