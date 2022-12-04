import 'package:flutter/material.dart';
import 'package:traveler/presentation/home/view/main_view.dart';
import 'package:traveler/presentation/resources/strings_manager.dart';
import 'package:traveler/presentation/splash/view/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String mainRoute = "/main";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
    case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) =>  const MainView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
