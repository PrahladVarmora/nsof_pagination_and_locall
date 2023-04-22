import 'package:nstack_softech_practical/modules/dashboard/view/screen_dashboard.dart';
import 'package:nstack_softech_practical/modules/splash/view/screen_splash.dart';

import 'common_import.dart';

/// > RouteGenerator is a class that generates routes for the application
/// It's a class that generates routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');
    //final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.routesSplash:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
      case AppRoutes.routesDashboard:
        return MaterialPageRoute(
            builder: (_) => const ScreenDashboard(),
            settings: const RouteSettings(name: AppRoutes.routesDashboard));

      default:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
    }
  }
}
