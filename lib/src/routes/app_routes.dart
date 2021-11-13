import 'package:ecommerce/src/pages/add_item_page.dart';
import 'package:ecommerce/src/pages/search_page.dart';
import 'package:ecommerce/src/pages/sign_in_page.dart';
import 'package:ecommerce/src/screens/home_screen.dart';
import 'package:ecommerce/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/signInPage':
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );
      case '/homeScreen':
        return MaterialPageRoute(
          builder: (context) => HomeScreen(title: 'eCommerce App'),
        );
      case '/searchPage':
        return MaterialPageRoute(
          builder: (context) => SearchPage(),
        );
      case '/addItemPage':
        return MaterialPageRoute(
          builder: (context) => AddItemPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );
    }
  }
}
