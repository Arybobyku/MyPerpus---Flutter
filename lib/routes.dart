import 'package:get/get.dart';
import 'package:my_perpus/ui/auth/login_page.dart';
import 'package:my_perpus/ui/auth/register_page.dart';
import 'package:my_perpus/ui/navigator_page.dart';
import 'package:my_perpus/ui/user/detailbuku/user_detail_buku.dart';
import 'package:my_perpus/ui/user/main_menu_page.dart';

import 'ui/user/search/user_search_page.dart';

class Routes {
  Routes._();

  static const String navigator = "/navigator";
  static const String login = "/login";
  static const String register = "/register";
  static const String mainMenu = "/mainMenu";
  static const String search = "/search";
  static const String detailBuku = "/detailBuku";

  static final newRoutes = <GetPage>[
    GetPage(name: navigator, page:()=>NavigatorPage()),
    GetPage(name: login, page:()=>LoginPage()),
    GetPage(name: register, page:()=>RegisterPage()),
    GetPage(name: mainMenu, page:()=>MainMenuPage()),
    GetPage(name: search, page:()=>UserSearchPage()),
    GetPage(name: detailBuku, page:()=>UserDetailBukuPage()),
  ];
}