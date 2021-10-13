import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/History/HistoryBinding.dart';
import 'package:unmasked_ai/Pages/History/HistoryUI.dart';
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
      page: () => HomeUI(),
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
