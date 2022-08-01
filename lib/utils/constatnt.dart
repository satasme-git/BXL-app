import 'package:flutter/painting.dart';

class Constants {
  //assets paths
  static const IMAGE_PATH = 'assets/';
  static const ICON_PATH = 'assets/icons/';

  //asset function
  static String imageAsset(img) => "$IMAGE_PATH$img";

  //icon assest function
  static String iconAsset(img) => "$ICON_PATH$img";

  static const Color iconColor = Color(0xFFB6C7D1);
  static const Color textColor1 = Color(0XFFA7BCC7);
  static const Color googleColor = Color(0xFFDE4B39);
  static const Color checkCircle = Color.fromARGB(255, 145, 145, 145);
  static const Color labelText = Color.fromARGB(255, 53, 53, 53);
}
