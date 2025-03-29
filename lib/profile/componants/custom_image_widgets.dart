import 'package:flutter/material.dart';
import 'package:simple_page/profile/constants/assets_images.dart';

class CustomImageWidgets extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  // final String showplaceholder;
  // final bool showError;
  // final Widget loadingWidget;
  // final Widget errorWidget;

  const CustomImageWidgets({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    // required this.showplaceholder,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage(AssetsImages.placeholder1),
      image: NetworkImage(url),
      fit: BoxFit.cover,
      width: width,
      height: height,
      // placeholder: showplaceholder? loadingWidget : null,
      // errorWidget: showError? errorWidget : null,
    );
  }
}
