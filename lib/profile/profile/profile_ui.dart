import 'package:faker/faker.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';
import 'package:simple_page/profile/componants/custom_image_widgets.dart';
import 'package:simple_page/profile/widgets/custom_bottom_nav.dart';
import 'package:simple_page/profile/widgets/custom_rounded_button_widget.dart';
import 'package:simple_page/profile/widgets/custom_widgets.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int _selectedIndex = 0;
  bool _isScrolled = false;

  final ScrollController _scrollController = ScrollController();

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
        backgroundColor: AppColors.tdBlue1,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeDisplay(),
            StatusIcons(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Add the controller here
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Added padding to the main body
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align to start
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
              const Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final label in ["All", "Supports", "Policies", "Education"])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomRoundedButton(label: label, onPressed: () {}),
                      ),
                  ],
                ),
              ),
              const Gap(30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(30, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0), // Reduced padding
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CustomImageWidgets(
                              url: Faker().image.loremPicsum(random: RandomGenerator().integer(1)),
                              height: 300,
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text('Name $index', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const Gap(20),
              const Text("Explore", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              const Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(20, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(Faker().image.loremPicsum(random: RandomGenerator().integer(1))),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 80,
                            child: Text('Name $index', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const Gap(20),
              ListView.builder(
                itemCount: 25,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomImageWidgets(
                          url: Faker().image.loremPicsum(random: RandomGenerator().integer(5)),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      title: Text(Faker().food.dish()),
                    ),
                  );
                },
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 16,
                  crossAxisSpacing: 16,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Added this line
                itemCount: 9, // added itemCount
                itemBuilder: (context, index) {
                  return CustomImageWidgets(
                    url: Faker().image.image(random: true),
                    width: 0,
                    height: 0,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
