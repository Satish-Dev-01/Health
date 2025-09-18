import 'package:get/get.dart';
import '../ui/splash/splash_view.dart';
import '../ui/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = <GetPage<dynamic>>[
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.home, page: () => const HomeView()),
  ];
}
