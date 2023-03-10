import 'package:connection_gap/presentation/screens/independent_screen.dart';
import 'package:connection_gap/presentation/screens/main_tabbed_screen.dart';
import 'package:flutter/material.dart';

abstract class AppNavigation {
  String get initialRoute;
  Map<String, Widget Function(BuildContext context)> get routes;
  Route<Object> onGenerateRoute(RouteSettings settings);
}

abstract class NavigationRouteNames {
  static const mainScreen = '/';
  static const independentScreen = '/independent';
  //...
}

class NavigationImpl implements AppNavigation {
  @override
  String get initialRoute => NavigationRouteNames.mainScreen;

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        NavigationRouteNames.mainScreen: (context) => const MainTabbedScreen(),
        NavigationRouteNames.independentScreen: (context) =>
            const IndependentScreen(),
      };

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //...
      default:
        const widget = Scaffold(body: Center(child: Text('Error')));
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

class NavigationActions {
  static const instance = NavigationActions._();
  const NavigationActions._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // back to previous or close dialog
  void returnToPreviousPage() {
    navigatorKey.currentState?.pop();
  }

  void onIndependentScreen() {
    navigatorKey.currentState
        ?.pushNamed(NavigationRouteNames.independentScreen);
  }
}
