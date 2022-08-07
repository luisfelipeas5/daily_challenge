import 'package:flutter/widgets.dart';

class RouletteDimens {
  static double getWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / _itemPerScreen;
  }

  static double getCardBackgroundHeight(BuildContext context) =>
      getWidth(context) - (horizontalMargin * 2);

  static double get horizontalMargin => 4.5;

  static const int _itemPerScreen = 4;
}
