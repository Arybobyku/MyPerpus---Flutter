import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_perpus/ui/navigator_page.dart';

class Routes{
  Routes._();
  static const String navigator = "/navigator";

  static final newRoutes = <GetPage>[
    GetPage(name: navigator, page:(){return const NavigatorPage();}),
  ];
}