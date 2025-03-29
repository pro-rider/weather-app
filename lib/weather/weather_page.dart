import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';
import 'package:simple_page/icons/link_icon.dart';
import 'package:simple_page/profile/widgets/custom_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tdBlue1,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LocationHeader(),
              const Gap(10),
              const TemperatureDisplay(),
              const Gap(25),
              Center(
                  child: Image.asset(
                'assets/images/sun12.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading image: $error');
                  return const Icon(Icons.error, size: 50, color: Colors.red);
                },
              )),
              const Gap(20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff171433).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                  child: Column(
                    children: [
                      WeatherRowItem(text: "Today", value: "12/23", iconPath: IconLoad.icon1),
                      const Gap(15),
                      WeatherRowItem(text: "Tomorrow", value: "13/24", iconPath: IconLoad.icon2),
                      const Gap(15),
                      WeatherRowItem(text: "Thursday", value: "34/24", iconPath: IconLoad.icon4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 8,
                            spacing: 8,
                            activeDotColor: AppColors.tdWhite,
                            dotColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

