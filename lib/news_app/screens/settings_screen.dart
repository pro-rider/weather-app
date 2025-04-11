import 'package:flutter/material.dart';
import 'package:simple_page/news_app/widgets/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/placeholders/avatar.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Michael Faraday',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'suren.bayalkoti2020@gmail.com',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SettingsItem(
              title: 'Dark Mood',
              isSwitch: true,
              switchValue: isDarkMode,
              onSwitchChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            const SettingsItem(title: 'Notifications'),
            const SettingsItem(title: 'Account'),
            const SettingsItem(title: 'Change Password'),
            const SettingsItem(title: 'Language'),
            const SettingsItem(title: 'Privacy & Security'),
            const SettingsItem(title: 'Help'),
          ],
        ),
      ),
    );
  }
}
