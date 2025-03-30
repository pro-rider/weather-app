import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_page/colors/color_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Automatically focus on the text field when screen opens
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search News',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.tdBlue1),
              textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Gap(15),
            TextField(
              controller: _searchController,
              autofocus: true, // Automatically shows the keyboard
              decoration: InputDecoration(
                // labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
