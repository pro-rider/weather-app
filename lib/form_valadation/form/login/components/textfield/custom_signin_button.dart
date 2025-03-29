import 'package:flutter/material.dart';
import 'package:simple_page/colors/color_widgets.dart';

class CustomSigninButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;
  final colorData;
  const CustomSigninButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
    this.colorData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 24,
              width: 24,
            ),
            const SizedBox(
                width: 8),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .primary,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
