import 'package:flutter/material.dart';
import 'package:simple_page/user_profile/model/data_model/data_model_forprofile.dart';

class ReusableProfileWidgets extends StatelessWidget {
  final ListItem item;
  ReusableProfileWidgets({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        item.icon,
      ),
      title: Text(
        item.title,
      ),
      onTap: (){},
    );
  }
}
