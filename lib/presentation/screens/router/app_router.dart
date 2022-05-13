import 'package:flutter/material.dart';
import 'package:weight_tracker_app/presentation/screens/auth/login_screen.dart';
import 'package:weight_tracker_app/presentation/screens/home/home_screen.dart';
import 'package:weight_tracker_app/presentation/screens/landing/landing_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case LandingScreen.id:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
    }
    return null;
  }
}
