import 'package:get/get.dart';
import 'routes_name.dart';
import 'package:flutter_state_management/view/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RoutesName.splashScreen, page: () => SplashScreen(), transition: Transition.leftToRightWithFade, transitionDuration: Duration(milliseconds: 250)),
      ];
}
