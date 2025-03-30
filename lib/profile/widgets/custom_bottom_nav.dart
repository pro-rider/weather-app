import 'package:flutter/material.dart';
import 'package:simple_page/colors/color_widgets.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor = AppColors.tdYellow;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    // activeColor: activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: activeColor,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "Add"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        // BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
      ],
    );
  }
}

