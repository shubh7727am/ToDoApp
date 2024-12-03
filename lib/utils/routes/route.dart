import 'package:flutter/material.dart';

import '../../views/home.dart';

// routes across the app
class Routes {
  static const String homeScreen = "/home_screen";
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) =>  const HomeScreen());
      default:
        return null; // Default route or error handling
    }
  }
}
