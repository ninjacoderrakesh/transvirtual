import 'package:transvirtual/screens/home/home_screen.dart';

import '../../constants/screens.dart'
    as screens;
import '../../screens/auth_pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../screens/splash/splash_screen.dart';
import 'custom_page_route.dart';

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    startScreen = const SplashScreen();

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case screens.loginRoute:
        return CustomPageRoute(
            direction: AxisDirection.down, child: const Login());
      case screens.homeRoute:
        return CustomPageRoute(
            direction: AxisDirection.down, child: const HomeScreen());
      default:
        return null;
    }
  }
}
