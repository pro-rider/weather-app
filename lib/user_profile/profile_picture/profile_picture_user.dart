import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';
import 'package:simple_page/user_profile/model/data_model/data_model_forprofile.dart';
// import 'size_config.dart';

class ProfilePictureUser extends StatefulWidget {
  const ProfilePictureUser({super.key});

  @override
  State<ProfilePictureUser> createState() => _ProfilePictureUserState();
}

class _ProfilePictureUserState extends State<ProfilePictureUser> {
  final List<ListItem> items = [
    ListItem(
      icon: Icons.location_on,
      title: 'Location',
    ),
    ListItem(
      icon: Icons.restaurant,
      title: 'Restaurant',
    ),
    ListItem(
      icon: Icons.local_offer,
      title: 'Deals',
    ),
    ListItem(
      icon: Icons.account_circle,
      title: 'Profiles',
    ),
    ListItem(
      icon: Icons.contacts,
      title: 'Address Book',
    ),
    ListItem(
      icon: Icons.rate_review,
      title: 'Reviews',
    ),
    ListItem(
      icon: Icons.info,
      title: 'About Us',
    ),
    ListItem(
      icon: Icons.help,
      title: 'FAQ',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.tdDarkBackground, // Dark background for header
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Gap(25),
            Row(
              children: [
                Gap(15),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.tdWhite,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: AppColors.tdBlack,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Text(
                      'John Smith Meu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'NEPAL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(15),
                // Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: AppColors.tdWhite, // White container
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    Icon(
                      Icons.star_border,
                      color: AppColors.tdBlack, // Black icon
                      size: 20.0,
                    ),
                  ],
                ),
                Gap(25),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.phone),
                          label: const Text('CALL US'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Gap(16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.email),
                          label: const Text('MAIL US'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // use that above ListItem through ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(items[index].icon, color: Colors.white),
                        title: Text(items[index].title,
                            style: const TextStyle(color: Colors.white)),
                        onTap: () {},
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    label: Text('Sign Out'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
