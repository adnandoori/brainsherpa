import 'package:brainsherpa/screens/authentication/login_screen.dart';
import 'package:brainsherpa/screens/authentication/sign_up_screen.dart';
import 'package:brainsherpa/screens/dashboard/dashboard_screen.dart';
import 'package:brainsherpa/screens/splash_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: Routes.login,
        page: () => LoginScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.signUp,
        page: () => SignUpScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashboardScreen(),
        transition: Transition.rightToLeftWithFade),
  ];
}
