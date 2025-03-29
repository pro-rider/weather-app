

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';


// Reusable Widgets:

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "09:21",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: AppColors.tdWhite,
      ),
    );
  }
}

class StatusIcons extends StatelessWidget {
  const StatusIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.signal_cellular_alt, color: Colors.white, size: 25),
        const SizedBox(width: 10),
        Icon(Icons.wifi, color: Colors.white, size: 25),
        const SizedBox(width: 10),
        Icon(Icons.battery_full, color: Colors.white, size: 25),
      ],
    );
  }
}

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "New York".toUpperCase(),
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: AppColors.tdWhite,
          ),
        ),
        const Gap(5),
        Icon(Icons.location_on, color: AppColors.tdWhite, size: 43.0),
        Icon(Icons.arrow_drop_down, color: AppColors.tdWhite, size: 43.0),
        const Spacer(),
        Icon(Icons.settings, color: AppColors.tdWhite, size: 30),
      ],
    );
  }
}

class TemperatureDisplay extends StatelessWidget {
  const TemperatureDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            "22°",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: AppColors.tdWhite,
            ),
          ),
          const Gap(20),
          Text(
            "Sunny",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: AppColors.tdWhite,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "22/14",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: AppColors.tdWhite,
            ),
          ),
        ],
      ),
    );
  }
}




class WeatherRowItem extends StatelessWidget {
  final String text;
  final String value;
  final String iconPath;

  const WeatherRowItem({
    super.key,
    required this.text,
    required this.value,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iconPath,
          color: AppColors.tdWhite,
          width: 50,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading image: $error');
            return const SizedBox(width: 20, height: 20);
          },
        ),
        const Gap(10),
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.tdWhite,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.tdWhite,
          ),
        ),
      ],
    );
  }
}
