import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';
import 'package:simple_page/profile/constants/assets_images.dart';
import 'package:simple_page/profile/widgets/custom_bottom_nav.dart';

class DiscoverCardWidgets extends StatefulWidget {
  const DiscoverCardWidgets({super.key});

  @override
  State<DiscoverCardWidgets> createState() => _DiscoverCardWidgetsState();
}

class _DiscoverCardWidgetsState extends State<DiscoverCardWidgets> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  bool _isScrolled = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels > 0) {
      if (!_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      }
    } else {
      if (_isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Discover Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Row
            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: AppColors.tdWhite,
                    backgroundImage: AssetImage(AssetsImages.placeholder9),
                  ),
                  
                  const SizedBox(width: 8.0),
                  Gap(20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fabrizio Romano',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '20.3M Followers',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Follow"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Image Section
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/placeholders/rugby4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Manchester United have finally reached agreement\n'
              'principles with Inter for Andre Onana.\n\n'
              '€50m package deal will be finalized next week\n'
              'with official documents, paperwork, contract to\n'
              'be signed.\n\n'
              'Erik ten Hag will have the goalkeeper he always\n'
              'wanted as a priority target - deal set to be sealed.\n\n'
              'Waiting Inter. Onana only played for\n'
              'Inter and then shined with standout\n'
              'performances. From 41 appearances, he recorded\n'
              '19 clean sheets and outstanding saves.',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}