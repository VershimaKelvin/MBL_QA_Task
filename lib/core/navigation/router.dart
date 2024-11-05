import 'package:flutter/material.dart';
import 'package:mbl/core/navigation/route_extentions.dart';
import 'package:mbl/core/navigation/route_name.dart';
import 'package:mbl/feature/auth/presentation/pages/login.dart';
import 'package:mbl/feature/auth/presentation/pages/signup.dart';




Route<T> onGenerateRoute<T>(RouteSettings settings) {
  switch (settings.name) {

    case RouteName.signup:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Signup(),
      );

    case RouteName.login:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Login(),
      );
    default:
      return MaterialPageRoute<T>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}



Route<T> _getPageRoute<T>({
  required String routeName,
  required Widget viewToShow,
}) {
  return PageRoutes.platform(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
