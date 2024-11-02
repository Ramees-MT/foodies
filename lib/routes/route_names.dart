import 'package:flutter/material.dart';
import 'package:foodies/view/bottomnavscreen.dart';
import 'package:foodies/view/cartscreen.dart';
import 'package:foodies/view/homescreen.dart';
import 'package:foodies/view/onboarding.dart';
import 'package:foodies/view/signinscreen.dart';
import 'package:foodies/view/signupscreen.dart';
import 'package:foodies/view/splashscreen.dart';
import 'package:foodies/view/welcomescreen.dart';

class AppRoutes {
  static const String welcomePage = '/';
  static const String signupPage = '/signup';
  static const String signinPage = '/signin';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  static const String homepage = '/homepage';
  static const String cartpage = '/cartpage';
  static const String bottomnavpage = '/bottomnavpage';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => Splashscreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case welcomePage:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case signupPage:
        return MaterialPageRoute(builder: (_) => Signupscreen());
      case signinPage:
        return MaterialPageRoute(builder: (_) => Signinscreen());
      case homepage:
        return MaterialPageRoute(builder: (_) => Homescreen());
      case cartpage:
        return MaterialPageRoute(builder: (_) => MyCartScreen());
      case bottomnavpage:
        return MaterialPageRoute(builder: (_) => MainScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
