import 'package:brainsherpa/screens/authentication/login_screen.dart';
import 'package:brainsherpa/screens/authentication/sign_up_screen.dart';
import 'package:brainsherpa/screens/dashboard/dashboard_screen.dart';
import 'package:brainsherpa/screens/dashboard/history_screen.dart';
import 'package:brainsherpa/screens/dashboard/reaction_time_list_screen.dart';
import 'package:brainsherpa/screens/dashboard/reaction_time_test_screen.dart';
import 'package:brainsherpa/screens/dashboard/start_test_screen.dart';
import 'package:brainsherpa/screens/splash_screen.dart';
import 'package:brainsherpa/screens/vitalsscreens/false_lapses_statistics_screen.dart';
import 'package:brainsherpa/screens/vitalsscreens/performance_score.dart';
import 'package:brainsherpa/screens/vitalsscreens/reaction_time_statistics.dart';
import 'package:brainsherpa/screens/vitalsscreens/cognitive_flexibility_screen.dart';
import 'package:brainsherpa/screens/vitalsscreens/vigilance_index_screen.dart';
import 'package:brainsherpa/screens/vitalsscreens/false_lapses_statistics_screen.dart';
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
    GetPage(
        name: Routes.reactionTimeTestScreen,
        page: () => const ReactionTimeTestScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.reactionTimeListScreen,
        page: () => const ReactionTimeListScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.historyScreen,
        page: () => const HistoryScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.startTestScreen,
        page: () => const StartTestScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.performanceScreen,
        page: () => const PerformanceScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.reactionStatistics,
        page: () => const ReactionStatistics(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.cognitiveFlexibilityScreen,
        page: () => const CognitiveFlexibilityScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.vigilanceIndexScreen,
        page: () => const VigilanceIndexScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.falseLapsesScreen,
        page: () => const falseLapsesScreen(),
        transition: Transition.rightToLeftWithFade)
  ];
}
