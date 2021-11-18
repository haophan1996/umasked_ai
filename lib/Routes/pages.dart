import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Result/ResultBinding.dart';
import 'package:unmasked_ai/Pages/Result/ResultUI.dart';
import 'package:unmasked_ai/Pages/Home/HomeBinding.dart';
import 'package:unmasked_ai/Pages/Home/HomeUI.dart';
import 'package:unmasked_ai/Pages/Search/SearchBinding.dart';
import 'package:unmasked_ai/Pages/Search/SearchUI.dart';
part 'routes.dart';

class AppPage {
  static const initial = Routes.home;
  static final pages = [
    GetPage(
      name: Routes.home,
      popGesture: true,
      gestureWidth: (context) => context.width,
      page: () => const HomeUI(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.search,
      popGesture: true,
      gestureWidth: (context) => context.width,
      page: () => SearchUI(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.history,
      popGesture: true,
      gestureWidth: (context) => context.width,
      page: () => HistoryUI(),
      binding: HistoryBinding(),
    ),
  ];
}
