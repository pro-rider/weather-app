import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';
// import 'package:simple_page/first_page/navigation/routes.dart';
import 'package:simple_page/profile/discover_card.dart/discover_card.dart';
// import 'package:simple_page/profile/constants/assets_images.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tdBGColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.tdBlack,
        selectedItemColor: AppColors.tdBlue1,
        unselectedItemColor: AppColors.tdGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover",
                  style: TextStyle(
                    color: AppColors.tdBlue1,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.notification_add_outlined, size: 40.0),
                    const Gap(10),
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 30, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.tdTransparent,
                image: DecorationImage(
                  image: AssetImage('assets/placeholders/rugby11.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 180,
              width: double.infinity,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiscoverCardWidgets(),
                      ),
                    );
                  },
                  child: Chip(
                      label: Text(
                        "All",
                        style: TextStyle(
                          color: AppColors.tdWhite,
                        ),
                      ),
                      backgroundColor: Colors.blueAccent),
                ),
                InkWell(
                  onTap: () {
                    // pushed named
                    Navigator.pushNamed(context, '/discover_card');
                  },
                  child: Chip(
                      label: Text(
                        "Sport",
                        style: TextStyle(
                          color: AppColors.tdWhite,
                        ),
                      ),
                      backgroundColor: Colors.blueAccent),
                ),
                InkWell(
                  onTap: () {
                    // pushed named
                    Navigator.pushNamed(context, '/discover_card');
                  },
                  child: Chip(
                      label: Text(
                        "Politics",
                        style: TextStyle(
                          color: AppColors.tdWhite,
                        ),
                      ),
                      backgroundColor: Colors.purple),
                ),
                InkWell(
                  onTap: () {
                    // pushed named
                    Navigator.pushNamed(context, '/discover_card');
                  },
                  child: Chip(
                      label: Text(
                        "Entertainment",
                        style: TextStyle(
                          color: AppColors.tdWhite,
                        ),
                      ),
                      backgroundColor: Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Explore",
              style: TextStyle(
                  color: AppColors.tdBlue1,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) {
                  List<String> images = [
                    'assets/placeholders/football.jpg',
                    'assets/placeholders/basketball.jpg',
                    'assets/placeholders/baseball.jpg',
                    'assets/placeholders/vollyball.jpg',
                    'assets/placeholders/cricket.jpg',
                  ];

                  List<String> names = [
                    'FootBall',
                    'Basketball',
                    'BaseBall',
                    'VolleyBall',
                    'Cricket',
                  ];

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.tdGrey,
                        backgroundImage: AssetImage(images[index]),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/discover_card',
                            arguments: {
                              'name': names[index],
                              'image': images[index],
                            },
                          );
                        },
                        child: Text(
                          names[index],
                          style: TextStyle(color: AppColors.tdBlue1),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Most Read",
              style: TextStyle(
                  color: AppColors.tdBlue1,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  List<String> images = [
                    'assets/placeholders/rugby12.jpg',
                    'assets/placeholders/rugby13.jpg',
                  ];

                  List<String> titles = [
                    "Eagles namayagpag kontra Archers \n sa Exhibition Game,",
                    "Cool Smashers spikes Akari Chargers \n down in Exhibition Game",
                  ];

                  List<String> subtitles = [
                    "Why Kirk Cousins might end up being the answer for Giants",
                    "How the new coach is turning the team around",
                  ];

                  return ListTile(
                    leading: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      titles[index],
                      style: TextStyle(color: AppColors.tdBlue1),
                    ),
                    subtitle: Text(
                      subtitles[index],
                      style: TextStyle(color: AppColors.tdBlack),
                    ),
                    onTap: () {
                      // Pass dynamic data to DiscoverCardWidgets
                      Navigator.pushNamed(
                        context,
                        '/discover_card',
                        arguments: {
                          'image': images[index],
                          'title': titles[index],
                          'subtitle': subtitles[index],
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
