import 'package:flutter/cupertino.dart';
// general dimensions to use accross the app
class Dimensions {
  // font-size
  static const double fontOverSmall = 7.00;
  static const double fontExtraSmall = 9.00;
  static const double fontSmall = 11.00;
  static const double fontDefault = 13.00;
  static const double fontLarge = 14.00;
  static const double fontMediumLarge = 17.00;
  static const double fontExtraLarge = 19.00;
  static const double fontOverLarge = 21.00;
  static const double fontMegaLarge = 28.00;
  static const double defaultButtonH = 45;
  static const double defaultRadius = 20;
  static int safeHeight = 50;
  static int safeWidth = 30;
  static int safeNodeHeight = 160;
  static int curveNodeCalibration = 22;
  static double nodeRadius = 50;
  static double nodeCenterFactor = 0.3;
  static double containerRadius = 30;
  static int delayDurationMillis = 1;
  static double barrierHeight = 70;
  static double barrierWidth = 70;
  static double bottomSheetContainerHeight = 100;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }


  static double getProportionalWidth(double percentage) {
    return screenWidth * (percentage / 100);
  }

  static double getProportionalHeight(double percentage) {
    return screenHeight * (percentage / 100);
  }

  static const double buttonRadius = 4;
  static const double cardRadius = 8;
  static const double safePadding = 8;
  static const double bottomSheetRadius = 15;
  static const double groupCardRadius = 10;
  static const double groupRadius = 20;
  static const double textToTextSpace = 8;
}